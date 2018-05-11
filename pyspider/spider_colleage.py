# -*- coding: utf-8 -*-

import re
import urllib.request

from bs4 import BeautifulSoup

#存储全国大学数据
from spider_colleage.DBUtil import DBUtil

index_url = 'http://www.huaue.com/gxmd.htm'

def load_page_content(link):
    url_request = urllib.request.Request(link)
    url_response = urllib.request.urlopen(url_request)
    return url_response.read()

soup = BeautifulSoup(load_page_content(index_url), 'html.parser')
table2 = soup.find_all('table', id='table2') # id table2
colleage_links = table2[1].find_all('a', attrs={'href': re.compile('http://www.huaue.com/gx*')})




#print(table2[1])
util = DBUtil('think')
util.connect()

for temp_link in colleage_links:
   print(temp_link.get_text())
   util.save_to_index(temp_link.get_text(), temp_link['href'])
