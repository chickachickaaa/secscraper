require 'Nokogiri'
require 'open-uri'
require 'net/http'

doc = Nokogiri::HTML(open("https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&datea=&dateb=&company=&type=8-k&SIC=&State=&Country=&CIK=&owner=include&accno=&start=0&count=100"))
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
  text = file.grep(/"Until the Company achieves sustained profitability" | "does not have sufficient capital to meet its needs" | "continues to seek loans or equity placements to cover such cash needs" | "there can be no assurance that any additional funds will be available to cover expenses as they may be incurred" | "unable to raise additional capital" | "may be required to take additional measures to conserve liquidity" | "Suspending the pursuit of its business plan" | "The Company may need additional financing" | "We will incur expenses in connection with our SEC filing requirements and we may not be able to meet such costs" | "could jeopardize our filing status with the SEC"/)
    if text.size > 0
      p url
    end
  end
  i+=1
end