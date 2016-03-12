@Lists = new (Mongo.Collection)('lists')
Meteor.methods

  getLists: ->
    Lists.find()
    return

  newList: (name) ->
    Lists.insert
      name: name
      createdAt: new Date
      owner: Meteor.userId()
      username: Meteor.user().username
