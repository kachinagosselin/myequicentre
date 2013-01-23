#! /usr/bin/python
# -*- coding: utf-8 -*-

from urllib import urlopen
from BeautifulSoup import BeautifulSoup
import re

# open a file to output the data
out_file = "EquineNowBoardingRatebyState.txt"
fo = open(out_file, "w")

# Copy all of the content from the provided web page
for i in range(0, 848): #max: 3783
	print "Page: " + str(i)

	# Grab the link to the original article using a REGEX
	in_file = "BoardingSource/EquineNowBoarding" + str(i) + ".txt"
	webpage = open(in_file, "r")
	soup = BeautifulSoup(webpage)
	for tble in soup("table", {"class" : "ltbdr lft"}, limit=12):
		for details_row in tble("td", { "class" : "s ft"}):
			for section in details_row("b"):
				if 'Boarding Rate:' in section.string:
					rate = section.next.next.strip()
					rate = re.sub(' -', "", rate)
					if '-' not in rate:
						if '/Day' in rate:
							rate = re.sub('/Day', "", rate)
							rate = re.sub('\$', "", rate)
							try:
								rate = float(rate)*30
								if rate < 3000:
									fo.write("\n" + str(rate))
								else:
									fo.write("\n" + str(rate/30))
							except ValueError:
								pass

						elif '/Month' in rate:
							rate = re.sub('/Month', "", rate)
							rate = re.sub('\$', "", rate)
							try:
								rate = float(rate)
								fo.write("\n" + str(rate))
							except ValueError:
								pass

					for address_row in tble("td", { "class" : "s lft", "colspan" : "4"}):
						address_row = re.sub('<td colspan="4" class="s lft">\n', "", str(address_row))
						address_row = re.sub('<b>', "", address_row)
						address_row = re.sub("\n", "", address_row)
						address_row = re.sub("\d", "", address_row)
						address = re.sub("</b></td>","",address_row)
						address = address.strip()
						fo.write(", " + str(address))

					if '# of Stalls:' in section.string:
						capacity = section.next.next.strip()
						capacity = re.sub(' -', "", capacity)
						fo.write(", " + str(capacity))



