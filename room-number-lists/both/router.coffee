
# Router.route '/:job', (-> this.render 'job'), {name: 'job'}

Router.route '/:job', {
  action: -> this.render 'job'
  name: 'job'
  waitOn: -> Meteor.subscribe 'DataLists', this.params.job
  data: -> {
    lists: DataLists.find({job: this.params.job}).fetch()
  }
}

Router.route '/', {
  action: -> this.render 'search'
  name: 'search'
}
# Router.route '/', ->
  # this.render 'index'

