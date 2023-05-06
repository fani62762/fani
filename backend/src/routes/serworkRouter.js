const express=require('express');
const { getSerWorkert,getow,getw,createWork, getlimits, deleteWork,getAllworks,updateworkerrate,getSerWorker, getServiceWorker, getmyService} = require('../controllers/serworkControllers');

const servworkrouter=express.Router()

servworkrouter.post('/',createWork);
servworkrouter.delete('/', deleteWork );
servworkrouter.get('/',getAllworks);
servworkrouter.get('/1/',getServiceWorker);
servworkrouter.get('/2/',getmyService);
servworkrouter.get('/4/',getSerWorker);
servworkrouter.get('/3/',getlimits);
servworkrouter.put('/3/:name/:TypeServ',updateworkerrate);
servworkrouter.get('/4/:type/:hour',getw);
servworkrouter.get('/5/:type/:hour',getow);
servworkrouter.get('/6/:Wname/:TypeServ',getSerWorkert);



module.exports=servworkrouter;
