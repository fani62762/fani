const mongoose = require('mongoose');

mongoose.connect(

    'mongodb+srv://fananyamak:fanan@cluster0.inmtf1x.mongodb.net/fani?retryWrites=true&w=majority'
)
.then(()=>{
    console.log('connected');
})
.catch(()=>{
    console.log('unable to connect');
});