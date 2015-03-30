
# Router.route '/:job', (-> this.render 'job'), {name: 'job'}
Router.route '/blueprint', {
  action: -> this.render 'blueprint'
  name: 'blueprint'
}
