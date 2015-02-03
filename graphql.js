var parser = require('./graphql-parser');
var fs = require('fs');

function dump(object) {
  console.log(JSON.stringify(object, null, 2));
}

fs.readFile('./examples/friends.gql', 'utf8', function(err, code) {
  if (err) {
    console.log('Error reading friends.gql');
    console.log(err);
    return;
  }

  dump(parser.parse(code));
});
