const express=require('express');
const { getserv,getAllserv,createserv,updateserv,deleteserv } = require('../controllers/servController');

const router=express.Router()
router.get('/2/:type',getserv);
router.get('/',getAllserv);
router.post('/',createserv);
router.put('/:type',updateserv );
router.delete('/:type', deleteserv );


module.exports=router;//;