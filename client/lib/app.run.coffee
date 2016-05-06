angular.module 'app'
  .run ($log, $state) ->
    'ngInject'

    # if !Meteor.userId()
      # $state.go('login')
