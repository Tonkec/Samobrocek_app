require 'rubygems'
require 'open-uri'
require 'nokogiri'
 
page = Nokogiri::HTML(open("http://www.samoborcek.hr/linija.php?id=18"))
 
# working_day
wd_smb = page.xpath("//tbody//p")[6..11] 
wd_smb_a = wd_smb.collect {|x| x.text} 
wd_smb_h = Hash[*wd_smb_a] 
 
wd_zgb = page.xpath("//tbody//p")[13..18]
wd_zgb_a = wd_zgb.collect {|x| x.text} 
wd_zgb_h = Hash[*wd_zgb_a]
 
# saturday
st_smb = page.xpath("//tbody//p")[22..27]
st_smb_a = st_smb.collect {|x| x.text}
st_smb_h =  Hash[*st_smb_a]
 
st_zgb = page.xpath("//tbody//p")[29..34]
st_zgb_a = st_zgb.collect {|x| x.text}
st_zgb_h = Hash[*st_zgb_a]
 
# sunday
sn_smb = page.xpath("//tbody//p")[37..42]
sn_smb_a = sn_smb.collect {|x| x.text}
sn_smb_h = Hash[*sn_smb_a]
 
sn_zgb = page.xpath("//tbody//p")[44..49]
sn_zgb_a = sn_zgb.collect {|x| x.text}
sn_zgb_h = Hash[*sn_zgb_a]
 
hash1 = {"Samobor- Sv. Nedelja- Autobusni kolodovor" => { "Radni dan" => [wd_smb_h, wd_zgb_h],
         "Subota" => [st_smb_h, st_zgb_h],
         "Nedjelja" => [sn_smb_h, sn_zgb_h]  
}}

def iterating(hash)
hash.select do |key, value|
   puts key
   value.select do |k,v|
           v[0].select do |k1, v1|
           puts k1
           puts v1 
           end
           v[1].select do |k2, v2|
           puts k2
           puts v2
           end
         end
        end
end
 
 
File.open('all_data.json', 'w') do |f|  
 f.write iterating(hash1)
end  