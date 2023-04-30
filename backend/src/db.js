const mongoose = require('mongoose')
mongoose.connect('mongodb+srv://fananyamak:fanan@cluster0.inmtf1x.mongodb.net/fani?retryWrites=true&w=majority')
.then(() => {
    console.log('Connected to DB');
    })
.catch(() => {
    console.log('Unable to Connected to DB');
    }); 