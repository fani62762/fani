const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({

TypeServ: {
type: String,
required: true
},

Wname: {
type: String,
required: true
},

Price: {
type: String,
required: true
},

Hours: {
type: [String],
required: true
},

rating:{
type : Number,
default:0
},

timing:{
type : Number,
default:0
},
behave:{
 type : Number,
default:0
},
master:{
type : Number,
default:0
},

});
   
const model=mongoose.model('servwork',newSchema);
module.exports = model;

