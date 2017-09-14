
###
 @license
 Licence: GPLv2
 Author: https://github.com/ecrucru/numtel/
###


#-- Lists the available dictionaries
list = numtel.getLanguages()
list.push '*'
for i in [0..list.length-1]
	item = document.createElement 'option'
	item.value = item.text = list[i]
	document.getElementById('numtel_language').add(item)


#-- Finds the word when you click on the button
document.getElementById('numtel_submit').onclick = ->
	obj = numtel.findWord(  document.getElementById('numtel_input').value,
							document.getElementById('numtel_language').value)
	buffer = ''
	if obj is null
		alert 'No word has been found.'
	else
		for i in [0..obj.match.length-1]
			buffer += '<br/>' if buffer.length > 0
			buffer += "[#{obj.prefix}]" if obj.prefix.length > 0
			buffer += obj.match[i]
	document.getElementById('numtel_output').innerHTML = buffer
