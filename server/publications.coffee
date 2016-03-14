Meteor.publish 'tasks', ->
  Tasks.find $or: [
    { private: $ne: true }
    { owner: @userId }
  ]
Meteor.publish 'lists', ->
  Lists.find $or: [
    { owner: @userId }
  ]
