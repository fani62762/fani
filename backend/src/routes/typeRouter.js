const express=require('express');
const { updattypeimg,createtypet,gettype,createtype,updatetype,deletetype, getAlltype,alltypes } = require('../controllers/typeController');

const router=express.Router()
router.get('/2/:type',gettype);
router.get('/',getAlltype);
router.get('/3',alltypes);
router.post('/',createtype);
router.post('/1/',createtypet);
router.put('/:name',updatetype );
router.delete('/:name', deletetype );
router.put('/1/:type',updattypeimg);

module.exports=router;