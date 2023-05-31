const mongoose = require('mongoose')
const Schema = mongoose.Schema

const servSchema = new Schema({
  
type: {
type: String,
required: true,
unique: false,
},

name: {
type: String,
required: true,
unique: true,
},

avatar: {
type: String,  
default:"https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/servi%2Fserv.png?alt=media&token=593045be-80a5-4344-ab9c-ac9cd683b688&_gl=1*d6xten*_ga*MTI5MjY3ODc2Ny4xNjgyODY1ODkx*_ga_CW55HF8NVT*MTY4NTU0NDQ4MC40LjEuMTY4NTU0NDU4Ni4wLjAuMA..",  
}

});
   
const model=mongoose.model('serv',servSchema);
module.exports = model;