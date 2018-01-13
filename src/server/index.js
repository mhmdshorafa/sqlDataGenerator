const app = require('./server.js');

app.listen(8080, () => {
  console.log('Our app is running on http://localhost:' + 8080);
});
