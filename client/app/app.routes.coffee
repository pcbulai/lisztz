angular.module 'app'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'root',
        url: ''
        abstract: true
        views:
          'sidebar':
            templateUrl: 'client/app/lists/lists.html'
            controller: 'ListsCtrl'
            controllerAs: 'vm'
          # 'footer':
          #   templateUrl: 'client/app/layout/footer.html'

      .state 'root.tasks',
        url: '/'
        views:
          'container@':
            templateUrl: 'client/app/tasks/tasks.html'
            controller: 'TodosListCtrl'
            controllerAs: 'vm'
    $urlRouterProvider.otherwise '/'
