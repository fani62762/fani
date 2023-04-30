const mongoose = require('mongoose')
const Schema = mongoose.Schema

const typeSchema = new Schema({
    
type: {
type: String,
required: true,
unique: true,
},

hm: {
type: Boolean,
default:false,
required: true,
},

avatar: {
type: String, 
required: true
}

}); 
const model=mongoose.model('type',typeSchema);
module.exports = model;