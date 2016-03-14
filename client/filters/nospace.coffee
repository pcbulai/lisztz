angular.module('app').filter 'nospace', ->
  (value) ->
    if !value then '' else value.replace(RegExp(' ', 'g'), '')
