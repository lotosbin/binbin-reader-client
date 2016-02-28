var fs, path;

path = './';

fs = require('fs');

fs.watch(path, function() {
  if (location) {
    location.reload();
  }
});
