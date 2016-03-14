TodosListCtrl = ($scope, $meteor, $stateParams, $reactive) ->
  'ngInject'

  vm = this

  $reactive(@).attach $scope

  @listName = $stateParams.listId

  @listUrl = url: @listName

  @subscribe 'tasks'
  @subscribe 'lists'

  @helpers(
    list: () =>
      Lists.findOne @listUrl
    lists: () =>
      Lists.find {}
    tasks: () =>
      Tasks.find @getReactively('query'), sort: createdAt: -1
  )

  vm.addTask = (newTask, listId) ->
    console.log listId
    $meteor.call 'addTask', newTask, listId
    return

  vm.deleteTask = (task) ->
    $meteor.call 'deleteTask', task._id
    return

  vm.setChecked = (task) ->
    $meteor.call 'setChecked', task._id, !task.checked
    return

  vm.setPrivate = (task) ->
    $meteor.call 'setPrivate', task._id, !task.private
    return

  vm.setDate = (task, date) ->
    $meteor.call 'setDate', task._id, date
    return

  $scope.$watch angular.bind(@, ->
    @list
  ), =>
    if @list
      @query =
        listId: @list._id
        checked:
          $ne: false
    else
      @query = {}
    return

  vm.incompleteCount = =>
    Tasks.find(@query).count()


  return

angular.module('app').controller 'TodosListCtrl', TodosListCtrl
