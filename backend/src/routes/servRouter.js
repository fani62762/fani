const express=require('express');
const { getAllservn,getserv,getAllserv,createserv,updateserv,deleteserv } = require('../controllers/servController');

const router=express.Router()
router.get('/2/:type',getserv);
router.get('/',getAllserv);
router.post('/',createserv);
router.put('/:type',updateserv );
router.delete('/:type', deleteserv );
router.get('/3/:name',getAllservn);
//router.get('/4/:type',getAllservt);


module.exports=router;//;