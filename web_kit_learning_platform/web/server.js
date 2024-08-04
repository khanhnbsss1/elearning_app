// Define the variables
const express = require('express');
var path = require('path');
const app = express();
const PORT = 9090
const HOST = '192.168.1.234';
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, '../web')));
app.get('*', (_, res) => {
  res.sendFile(path.resolve(__dirname, '../web/index.html'));
});
// Listen to the network
app.listen(PORT, HOST, () => {
    console.log(`Server running on port http://${HOST}:${PORT}`);
});