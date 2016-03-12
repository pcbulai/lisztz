onReady = ->
  angular.bootstrap document, [ 'app' ]
  return

Accounts.ui.config passwordSignupFields: 'USERNAME_ONLY'
if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady
