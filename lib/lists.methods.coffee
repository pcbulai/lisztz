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
      username: Meteor.user().username

    return

  deleteList: (listId) ->

    list = Lists.findOne(listId)

    Tasks.remove listId: listId

    if list.private and list.owner != Meteor.userId()
      # If the list is private, make sure only the owner can delete it
      throw new (Meteor.Error)('not-authorized')

    Lists.remove listId

    return

  findList: (listUrl) ->

    list = Lists.findOne(listUrl)

    return list
