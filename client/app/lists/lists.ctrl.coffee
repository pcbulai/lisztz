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

  return

angular.module('app').controller 'ListsCtrl', ListsCtrl
