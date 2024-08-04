// Define the variables
const express = require('express');
const app = express();
const PORT = 60000;
const HOST = '192.168.1.234:9090';

// Serve static files from the project directory
app.use(express.static('.'));

// Listen to the network
app.listen(PORT, HOST, () => {
    console.log(`Server running on port http://${HOST}:${PORT}`);
});