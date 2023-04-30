const express= require('express');
const { adduser,getallUser,updateuser,getsingleuser ,deleteuser} = require('../controllers/usercontrol');

const myrouter =express.Router();

myrouter.get('/',getallUser);

myrouter.get('/:name',getsingleuser);

myrouter.post('/',adduser);

myrouter.delete('/:name',deleteuser);

myrouter.put('/:name',updateuser);

module.exports=myrouter;