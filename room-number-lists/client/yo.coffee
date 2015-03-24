
Template.widg.helpers {
  'currentState' : -> 
    console.log "console.log Template.instance()"
    console.log Template.instance()
    console.log "console.log this"
    console.log this
    console.log "Template.currentData()"
    console.log Template.currentData()
    return "temp"
}