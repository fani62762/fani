const express=require('express');
const { deleteservworker,getSerWorkert,getow,getw,createWork, getlimits, deleteWork,getAllworks,updateworkerrate,getSerWorker, getServiceWorker, getmyService} = require('../controllers/serworkControllers');

const servworkrouter=express.Router()

servworkrouter.post('/',createWork);
servworkrouter.delete('/', deleteWork );
servworkrouter.delete('/:name', deleteservworker );
servworkrouter.get('/',getAllworks);
servworkrouter.get('/1/',getServiceWorker);
servworkrouter.get('/2/',getmyService);
servworkrouter.get('/4/',getSerWorker);
servworkrouter.get('/3/',getlimits);
servworkrouter.put('/7',updateworkerrate);
servworkrouter.get('/4/:type/:hour',getw);
servworkrouter.get('/5/:type/:hour',getow);
servworkrouter.get('/6',getSerWorkert);




module.exports=servworkrouter;
