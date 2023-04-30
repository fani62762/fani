const mongoose= require('mongoose');
const userSchema=mongoose.Schema({
    username : String,
    email: String,
    password:String,
    gender :String,
    phone :String,
    dateofbirth:String
});

const model=mongoose.model('user',userSchema);

module.exports=model;