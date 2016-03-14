angular.module('app').filter 'capitalize', ->
  (input, format) ->
    if !input
      return input
    format = format or 'all'
    if format == 'first'
      # Capitalize the first letter of a sentence
      input.charAt(0).toUpperCase() + input.slice(1).toLowerCase()
    else
      words = input.split(' ')
      result = []
      words.forEach (word) ->
        if word.length == 2 and format == 'team'
          # Uppercase team abbreviations like FC, CD, SD
          result.push word.toUpperCase()
        else
          result.push word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
        return
      result.join ' '
