@Lists = new (Mongo.Collection)('lists')
Meteor.methods

  addList: (name) ->

    if !Meteor.userId()
      throw new (Meteor.Error)('not-authorized')

    Lists.insert
      name: name
      url: name.replace(RegExp(' ', 'g'), '-').toLowerCase()
      createdAt: new Date
      owner: Meteor.userId()
      private: true
      username: Meteor.user().username

    return

  deleteList: (listId) ->

    list = Lists.findOne(listId)

    if list.private and list.owner != Meteor.userId()
      # If the list is private, make sure only the owner can delete it
      throw new (Meteor.Error)('not-authorized')


    Lists.remove listId
    Tasks.remove listId: listId

    return

  setPrivateList: (listId, setToPrivate) ->
    list = Lists.findOne(listId)

    # Make sure only the task owner can make a task private
    if list.owner != Meteor.userId()
      throw new (Meteor.Error)('not-authorized')
    Tasks.update listId: listId,
      $set:
        private: setToPrivate
    , multi: true
    Lists.update listId, $set: private: setToPrivate


    return
