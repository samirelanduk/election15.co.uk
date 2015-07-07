#This script will get the 2015 voting data from the BBC, and save
#it to an sqlite database. There will be a table for constituencies
#and one for parties

import os
from bs4 import BeautifulSoup
import sqlite3
import requests


#Go to constituencies page
soup = BeautifulSoup(requests.get("http://www.bbc.co.uk/news/politics/constituencies").text)

#Get a list of 650 urls
urls = []
div = soup.find(attrs={"id":"council_data-az_constituency_list"})
div = [x for x in div if x != "\n"]
for table in div:
    a = table.find_all("a")
    urls += ["http://www.bbc.co.uk" + x["href"] for x in a]

#Grab the SVG map
f = open("map.xml")
map_soup = BeautifulSoup(f.read(), "xml")
f.close()

#Go to each URL and get the data there
constituencies = []
counter = 1
lookup = {"E":"England", "S":"Scotland", "W":"Wales", "N":"Northern Ireland"}
    

for url in urls:
    print("Starting %d of 650" % counter)

    #get 'nation'
    constituency = {}
    code = url.split("/")[-1]
    constituency["nation"] = lookup[code[0]]

    #Get name, tuunout and GAIN status
    c_soup = BeautifulSoup(requests.get(url).text)
    constituency["name"] = c_soup.find(
        "h1", attrs={"class":"constituency-title__title"}).text
    constituency["turnout"] =float(
        c_soup.find_all("span", attrs={"class":"results-turnout__value--right"})[1].text[:-1])
    constituency["gain"] = c_soup.find(
        "span", attrs={"class":"ge2015-background__party"}).text

    #Get location
    path = map_soup.find_all("g")[0].find_all("path", attrs={"data-gssid":code})[0]
    constituency["svg_string"] = path["d"]

    #Get votes
    parties = c_soup.find(
        attrs={"id":"general_election_data-constituency_result_table"}).find_all(attrs={"class":"party"})
    constituency["results"] = [{"party":x.find(attrs={"class":"party__name--long"}).text,
                "votes":int(x.find(attrs={"class":"party__result--votes"}).text.split(" ")[0].replace(",","")),
                "change":float(x.find(attrs={"class":"party__result--votesnet essential"}).text.split()[0][:-1])} for x in parties]

    constituencies.append(constituency)
    counter += 1

print("%d is the maximum number of parties in a constituency" % max([len(x["results"]) for x in constituencies]))

#Rearrange some data to get a parties object
parties = []
for c in constituencies:
    for result in c["results"]:
        if result["party"] not in parties: parties.append(result["party"])
parties = [{"name":x, "total_votes":0, "seats_fought":0, "seats_won":0} for x in parties]

for party in parties:
    for c in constituencies:
        if party["name"] in [x["party"] for x in c["results"]]:
            party["seats_fought"] += 1
            for result in c["results"]:
                if result["party"] == party["name"]:
                    party["total_votes"] += result["votes"]
                    if result["votes"] == max([x["votes"] for x in c["results"]]): party["seats_won"] += 1
parties = sorted(parties, key = lambda k: k["total_votes"])
parties.reverse()
            

#Save to SQLite database
conn = sqlite3.connect("data.db")
c = conn.cursor()

#First the parties
c.execute("CREATE TABLE parties (name text, total_votes integer, seats_fought integer, seats_won integer)")
for party in parties:
    c.executemany("INSERT INTO parties VALUES (?, ?, ?, ?)",
                  [(party["name"], party["total_votes"], party["seats_fought"], party["seats_won"])])

#Then the constituencies
c.execute("CREATE TABLE constituencies (name text, turnout real, nation text, gain text, svg_string text, results_json text)")
for constituency in constituencies:
    c.executemany("INSERT INTO constituencies VALUES (?, ?, ?, ?, ?, ?)",
                  [(constituency["name"], constituency["turnout"], constituency["nation"], constituency["gain"], constituency["svg_string"], str(constituency["results"]))])

conn.commit()
conn.close()

    
