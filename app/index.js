const express = require('express');

const app = express();
const port = 80;

app.get('/', (_req, res) => {
  res.send('Hello from Containers running on Amazon EC2!');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
