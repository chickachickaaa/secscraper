require 'Nokogiri'
require 'open-uri'
require 'net/http'

doc = Nokogiri::HTML(open("https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&datea=&dateb=&company=&type=8-k&SIC=&State=&Country=&CIK=&owner=include&accno=&start=100&count=200"))
href = []
links = doc.css('a')
links.each do |link|
  if link['href'] =~ /[.][t][x][t]/
    href << link['href']
  end
end
i = 0
while href.size > i do
  url = "https://www.sec.gov#{href[i]}"
  file = open(url)
  file2 = open(url)
  first_word = file.grep(/covenant/)
  if first_word.size > 0
      second_word = file2.grep(/violated | violation | non-compliance | out of compliance/)
    if second_word.size > 0
      p url
    end
  end
  i+=1
end