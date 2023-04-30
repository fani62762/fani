const express=require('express');
const { gettype,createtype,updatetype,deletetype, getAlltype,alltypes } = require('../controllers/typeController');

const router=express.Router()
router.get('/2/:type',gettype);
router.get('/',getAlltype);
router.get('/3',alltypes);
router.post('/',createtype);
router.put('/:name',updatetype );
router.delete('/:name', deletetype );

module.exports=router;