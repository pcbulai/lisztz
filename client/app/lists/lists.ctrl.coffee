ListsCtrl = ($scope, $meteor, $reactive) ->
  'ngInject'

  vm = this

  $reactive(@).attach $scope

  @subscribe 'lists'

  @helpers(
    lists: () ->
      Lists.find {}
  )

  @addList = (newList) ->
    $meteor.call 'addList', newList
    return

  @deleteList = (listId) ->
    $meteor.call 'deleteList', listId
    return

  @setPrivate = (listId, setPrivate) ->
    $meteor.call 'setPrivateList', listId, setPrivate
    return

  return

angular.module('app').controller 'ListsCtrl', ListsCtrl
