# this is how ids are generated:
genId = (pid) -> # pass a parentId in order to get your id
  padDigits = (number, digits) ->
    return Array(Math.max(digits - String(number).length + 1, 0)).join(0) + number

  mongoID = new Mongo.ObjectID()
  prefix = padDigits Date.now(), 15
  hexString = mongoID.toHexString()
  id = [prefix, hexString].join "-"
  return [pid, id].join "/"


window.xs2 = []
xs2.push genId('root')
xs2.push genId('root')
xs2.push genId('root')
xs2.push genId('root')
xs2.push genId('root')
xs2.push genId('root')

_.times 100, -> xs2.push genId(xs2[ xs2.length - 1 ])


# xs2.push "root/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "root/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "root/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "#{xs2[0]}/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "#{xs2[3]}/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "#{xs2[2]}/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"
# xs2.push "#{xs2[5]}/#{padDigits Date.now(), 15}-#{new Mongo.ObjectID()}"