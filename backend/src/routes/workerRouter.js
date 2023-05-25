const express= require('express');
const {gendercount,addworker,getallworker,forgotPassword,updateworker,updateworkerbio,getsingleworker,deleteworker,updateworkerimg,getworker,submitCredentials, updateworkerrate, updateworkerLoc} = require('../controllers/workercontrol');
const workerrouter =express.Router();
const cors = require('cors');

workerrouter.use(cors());
workerrouter.get('/1/:userId', getsingleworker );
workerrouter.get('/2/:name',getworker);
workerrouter.get('/wgender',gendercount);
workerrouter.post('/login',submitCredentials);
workerrouter.get('/',getallworker);
workerrouter.post('/',addworker);
workerrouter.delete('/:name',deleteworker);
workerrouter.put('/1/:name',updateworkerimg);
workerrouter.put('/2/:name',updateworker);
workerrouter.put('/location/:name',updateworkerLoc);
workerrouter.put('/3/:name',updateworkerrate);
workerrouter.put('/4/:name',updateworkerbio);
workerrouter.post('/forgot-password', forgotPassword);//

module.exports=workerrouter;