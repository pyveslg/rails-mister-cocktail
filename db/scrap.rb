require 'open-uri'
require 'nokogiri'

musees_name = []
musees_address = []

i = [*0..3]
i.each do |i|
  html_file = open("http://www.culture.gouv.fr/public/mistral/museo_fr?ACTION=RETROUVER_TITLE&FIELD_4=REGION&VALUE_4=ILE-DE-FRANCE&GRP=#{i}&SPEC=9&SYN=1&IMLY=&MAX1=1&MAX2=1&MAX3=50&REQ=%28%28ILE-DE-FRANCE%29%20%3aREGION%20%29&DOM=All&USRNAME=nobody&USRPWD=4%24%2534P")
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('td#contenu:nth-child(2) tr td:nth-child(4)').each do |element|
    musees_name << element.text
  end

  html_doc.search('td#contenu:nth-child(2) tr td:nth-child(5)').each do |element|
    musees_address << element.text
  end
end

musees = []
musees_name.each_with_index do |nom, i|
  musees << {name: nom, address: musees_address[i]}
end

p musees



