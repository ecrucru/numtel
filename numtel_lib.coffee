
###
 @license
 Licence: GPLv2
 Author: https://github.com/ecrucru/numtel/
###


#-- Main class
class NumTel
	#- Initializes the internal data
	constructor: ->
		@_m_dictionary = {}

	#- Adds a new array of words for a given language
	declareLanguage: (pISO2, pData) ->
		return false if (pISO2.length != 2) or !Array.isArray(pData)
		for i in [0..pData.length-1]
			pData[i] = pData[i].toLowerCase().split('-').join('')
			if !pData[i].match(/^[a-z]+$/)
				pData[i] = ''
		@_m_dictionary[pISO2.toLowerCase()] = pData
		true

	#- Gets the loaded languages
	getLanguages: ->
		result = Object.keys(@_m_dictionary)
		result.sort()
		result

	#- Analyzes the phone number to get a suitable word
	findWord: (pPhoneNumber, pLanguage) ->
		# Checks
		return null if pPhoneNumber.length == 0

		# Languages to scan
		if Array.isArray(pLanguage)
			langs = pLanguage
		else
			if pLanguage is '*'
				langs = @getLanguages()
			else
				langs = [pLanguage]

		# Intelligent loop
		match = []
		debugger
		for p in [0..pPhoneNumber.length-1]
			prefix = pPhoneNumber.substring(0, p)
			phone = pPhoneNumber.substring(p)

			# Defines the mask
			mask = ''
			for i in [0..phone.length-1]
				mask += [' ', ' ', '[a-c]', '[d-f]', '[g-i]', '[j-l]', '[m-o]', '[p-s]', '[t-v]', '[w-z]'][parseInt(phone[i])]
			regexp = new RegExp("^#{mask}$", 'i')

			# Scans every language
			for lang in [0..langs.length-1]
				if @_m_dictionary[langs[lang]] is undefined
					continue

				# Looks for a result
				for i in [0..@_m_dictionary[langs[lang]].length-1]
					word = @_m_dictionary[langs[lang]][i]
					if word.match regexp
						if match.indexOf(word) is -1
							match.push word

			# Result
			if match.length > 0
				return
					prefix : prefix
					phone  : phone
					match  : match

		# No result
		null


#-- Entry point
numtel = new NumTel()
