TodosListCtrl = ($scope, $meteor) ->
  'ngInject'

  vm = this

  $scope.subscribe 'tasks'

  vm.tasks = $meteor.collection(->
    Tasks.find $scope.getReactively('vm.query'), sort: createdAt: -1
  )

  vm.addTask = (newTask) ->
    $meteor.call 'addTask', newTask
    return

  vm.addNewList = (name) ->
    $meteor.call 'addList', name
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

  vm.click = ->
    $meteor.call 'getLists', (data) ->
      console.log data
      return
    return

  $scope.$watch angular.bind(this, ->
    @hideCompleted
  ), ->
    if vm.hideCompleted
      vm.query = checked: $ne: true
    else
      vm.query = {}
    return

  vm.incompleteCount = ->
    Tasks.find(checked: $ne: true).count()
  return

angular.module('app').controller 'TodosListCtrl', TodosListCtrl
