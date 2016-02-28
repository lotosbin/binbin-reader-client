path = './'
fs = require('fs')
fs.watch path, ->
  if location
    location.reload()
  return
