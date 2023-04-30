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
}

});
   
const model=mongoose.model('serv',servSchema);
module.exports = model;