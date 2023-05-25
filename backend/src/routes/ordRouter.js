const express=require('express');
const {getUserord,getUserordwork,getOrderCountsByService,getOrdersCountByDay,getOrdersCountByMonth,getUserordc, getorder,createord,deleteord,getworkordd,getworkordu,getUserordd,getUserordu,updateaccw,updateaccu} = require('../controllers/ordController');

const router=express.Router()
router.get('/1/:id', getorder );
router.get('/getmon', getOrdersCountByMonth );
router.get('/getday', getOrdersCountByDay );
router.get('/getservord', getOrderCountsByService );
router.post('/',createord);
router.delete('/:id', deleteord );
router.get('/5/:name',getworkordd);
router.get('/6/:name',getworkordu);
router.get('/3/:name',getUserordd);
router.get('/4/:name',getUserordu);
router.get('/9/:name',getUserordc);
router.put('/7/:id',updateaccw);
router.put('/8/:id',updateaccu);
router.get('/10/:uname/:wname',getUserordwork);
router.get('/11/:uname',getUserord);

module.exports=router;