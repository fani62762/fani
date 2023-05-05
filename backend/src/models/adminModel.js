const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    
email: {
type: String,
required: true,
},

password: {
type: String,
required: true
},

name: {
type: String,
required: true,
unique: true
},

phone: {
type: String,
required: true,
},

gender:
{
type: String,
default:""
},
    
image:
{
type:String,
default:"https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5"      
},
    


});
   
const model=mongoose.model('Admin',newSchema);
module.exports = model;