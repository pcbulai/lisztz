TodosListCtrl = ($scope, $stateParams, $reactive) ->
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
      Tasks.find @getReactively('query'), sort: checked: false, createdAt: -1
  )

  @addTask = (newTask, listId) =>
    @call 'addTask', newTask, listId
    return

  @deleteTask = (task) =>
    @call 'deleteTask', task._id
    return

  @setChecked = (task) =>
    @call 'setChecked', task._id, !task.checked
    return

  @setPrivate = (task) =>
    @call 'setPrivate', task._id, !task.private
    return

  @setDate = (task, date) =>
    @call 'setDate', task._id, date
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
