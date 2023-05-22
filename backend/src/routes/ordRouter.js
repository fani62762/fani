const express=require('express');
const {getOrdersCountByMonth,getUserordc, getorder,createord,deleteord,getworkordd,getworkordu,getUserordd,getUserordu,updateaccw,updateaccu} = require('../controllers/ordController');

const router=express.Router()
router.get('/1/:id', getorder );
router.get('/getOrdersCountByMonth', getOrdersCountByMonth );
router.post('/',createord);
router.delete('/:id', deleteord );
router.get('/5/:name',getworkordd);
router.get('/6/:name',getworkordu);
router.get('/3/:name',getUserordd);
router.get('/4/:name',getUserordu);
router.get('/9/:name',getUserordc);
router.put('/7/:id',updateaccw);
router.put('/8/:id',updateaccu);

module.exports=router;