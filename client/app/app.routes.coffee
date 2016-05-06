angular.module 'app'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'root',
        url: ''
        abstract: true

      .state 'login',
        url: '/login'
        template: 'hello!'

      .state 'root.tasks',
        url: '/:listId'
        views:
          'sidebar':
            templateUrl: 'client/app/lists/lists.html'
            controller: 'ListsCtrl'
            controllerAs: 'vm'

          'container':
            templateUrl: 'client/app/tasks/tasks.html'
            controller: 'TodosListCtrl'
            controllerAs: 'vm'

    $urlRouterProvider.otherwise '/inbox'
