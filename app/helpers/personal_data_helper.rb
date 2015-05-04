module PersonalDataHelper
	def getAddress(postal_code)
		result = `curl "http://www.google.com/transliterate?langpair=ja-Hira|ja&text=#{postal_code}"`
		result[/^\[+.+\["([^"]+)/,1]
	end
end
