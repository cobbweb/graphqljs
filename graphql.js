var parser = require('./graphql-parser');
var fs = require('fs');

function dump(object) {
  console.log(JSON.stringify(object, null, 2));
}

fs.readFile('./examples/simple.gql', 'utf8', function(err, code) {
  if (err) {
    console.log('Error reading simple.gql');
    console.log(err);
    return;
  }

  dump(parser.parse(code));
});