// Define the variables
const express = require('express');
const app = express();
const PORT = 60000;
const HOST = '0.0.0.0';

// Serve static files from the project directory
app.use(express.static('.'));

// Listen to the network
app.listen(PORT, HOST, () => {
    console.log(`Server running on port http://${HOST}:${PORT}`);
});