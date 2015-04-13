Masin = (initState) ->
  prefix = (new Mongo.ObjectID).toHexString()
  addPrefix = (str) -> "#{prefix}__#{str}"
  updateSession = (newState) -> 
    re = new RegExp "^#{prefix}"
    activeKeys = R.keys(newState)
    allSessionKeys = R.filter R.match(re), R.keys(Session.keys)
    activeSessionKeys = R.map addPrefix, activeKeys
    inactiveSessionKeys = R.difference allSessionKeys, activeSessionKeys
    update = (k) -> Session.set addPrefix(k), newState[k]
    clear = (str) -> Session.set str, undefined
    R.forEach update, activeKeys
    R.forEach clear, inactiveSessionKeys
    return api
  updateSession initState
  api = {
    to : updateSession
    has : (str) -> Session.get(addPrefix str)?
    current : (str) -> Session.get addPrefix(str)
  }
@Masin = Masin