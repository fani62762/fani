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

uname: {
type: String,
required: true
},

Price: {
type: String,
required: true
},

Hour: {
type: String,
required: true
},

serv: {
type: [String],
required: true
},

date: {
type: String,
required: true
},

add: {
type: [String],
},

isrepeated: {
type: String,
},

acc: {
type: Number,
},

rating:{
type : Number,
default:0
},

});
const model=mongoose.model('ord',newSchema);
module.exports = model;