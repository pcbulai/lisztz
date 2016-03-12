@Tasks = new (Mongo.Collection)('tasks')
Meteor.methods

  addTask: (text) ->
    # Make sure the user is logged in before inserting a task
    if !Meteor.userId()
      throw new (Meteor.Error)('not-authorized')

    Tasks.insert
      text: text
      createdAt: new Date
      owner: Meteor.userId()
      username: Meteor.user().username

    Lists.insert count: Tasks.find().count()
    return

  deleteTask: (taskId) ->
    task = Tasks.findOne(taskId)

    if task.private and task.owner != Meteor.userId()
      # If the task is private, make sure only the owner can delete it
      throw new (Meteor.Error)('not-authorized')

    Tasks.remove taskId
    return

  setChecked: (taskId, setChecked) ->
    task = Tasks.findOne(taskId)

    if task.private and task.owner != Meteor.userId()
      # If the task is private, make sure only the owner can check it off
      throw new (Meteor.Error)('not-authorized')

    Tasks.update taskId, $set: checked: setChecked
    return

  setPrivate: (taskId, setToPrivate) ->
    task = Tasks.findOne(taskId)

    # Make sure only the task owner can make a task private
    if task.owner != Meteor.userId()
      throw new (Meteor.Error)('not-authorized')

    Tasks.update taskId, $set: private: setToPrivate
    return

  setDate: (taskId, date) ->
    task = Tasks.findOne(taskId)

    if task.owner != Meteor.userId()
      throw new (Meteor.Error)('not-authorized')
    Tasks.update taskId, $set: dueDate: date

    return

  setList: (taskId, list) ->
    task = Tasks.findOne(taskId)

    if task.owner != Meteor.userId()
      throw new (Meteor.Error)('not-authorized')

    Tasks.update taskId, $set: list: list
    return
