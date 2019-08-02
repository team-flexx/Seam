var express = require('express');
var ParseServer = require('parse-server').ParseServer;
var app = express();

var api = new ParseServer({
  databaseURI: 'mongodb://heroku_cm03672n:nos14mprcq3npfcdrj3u0355jc@ds139801.mlab.com:39801/heroku_cm03672n', // Connection string for your MongoDB database
  cloud: '/home/myApp/cloud/main.js', // Absolute path to your Cloud Code
  appId: 'flexx',
  masterKey: 'flexx', // Keep this key secret!
  fileKey: 'optionalFileKey',
  serverURL: 'https://seam-flexx.herokuapp.com/parse' // Don't forget to change to https if needed
});

// Serve the Parse API on the /parse URL prefix
app.use('/parse', api);

app.listen(1337, function() {
  console.log('parse-server-example running on port 1337.');
});
