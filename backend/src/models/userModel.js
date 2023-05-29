const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    
email: {
type: String,
default:"لم يتم التعيين بعد"
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
default:"لم يتم التعيين بعد"
},

date:
{
type: String,
default:"لم يتم التعيين بعد"
},
    
image:
{
type:String,
default:"https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5"      
},
    
address:
{
type:String,
default:"لم يتم تعين الموقع "
}, 
Token:
{
type:String,
default:""
}, 

latitude:
{
type: Number,
default:32.228263850000005
},

longitude:
{
type: Number,
default:35.22223124412008
},
pref: {
    type: String,
   
},

});
   
const model=mongoose.model('Users',newSchema);
module.exports = model;