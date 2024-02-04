// Import required modules
const express = require('express');
const path = require('path');

// Create an instance of Express
const app = express();

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, 'public')));

// Add a GET method for /learning route
app.get('/', (req, res) => {
    res.redirect('/index.html');
});

// Add a GET method for /learning route
app.get('/learning', (req, res) => {
    res.redirect('/learning.html');
});

// Start the server
app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
