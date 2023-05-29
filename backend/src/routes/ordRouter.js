const express=require('express');
const {deleteordsusers,retrieveWorkerssByuname,retrieveUnamesByWorker,getworkord,deleteordsworker,getallorder,getUserord,getUserordwork,getOrderCountsByService,getOrdersCountByDay,getOrdersCountByMonth,getUserordc, getorder,createord,deleteord,getworkordd,getworkordu,getUserordd,getUserordu,updateaccw,updateaccu} = require('../controllers/ordController');

const router=express.Router()
router.get('/1/:id', getorder );
router.get('/', getallorder );
router.get('/getmon', getOrdersCountByMonth );
router.get('/retrieveUnams/:Wname', retrieveUnamesByWorker );
router.get('/retrieveWnams/:uname', retrieveWorkerssByuname );
router.get('/getday', getOrdersCountByDay );
router.get('/getservord', getOrderCountsByService );
router.post('/',createord);
router.delete('/:id', deleteord );
router.delete('/delse/:Wname', deleteordsworker );
router.delete('/delseordsuser/:uname', deleteordsusers );
router.get('/5/:name',getworkordd);
router.get('/6/:name',getworkordu);
router.get('/3/:name',getUserordd);
router.get('/4/:name',getUserordu);
router.get('/9/:name',getUserordc);
router.put('/7/:id',updateaccw);
router.put('/8/:id',updateaccu);
router.get('/10/:uname/:Wname',getUserordwork);
router.get('/11/:uname',getUserord);
router.get('/12/:Wname',getworkord);

module.exports=router;