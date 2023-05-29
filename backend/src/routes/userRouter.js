const express=require('express');
const { delemail,gendercount,adduser,forgotPassword, getAllUsers,submitCredentials,updateuserimg,updatUsererLoc, updateUser, deleteUser, getSingleUser, getUser } = require('../controllers/userControllers');
const cors = require('cors');
const router=express.Router()
router.use(cors());
router.get('/1/:userId', getSingleUser );
router.get('/2/:name',getUser);
router.get('/ugender',gendercount);
router.post('/login',submitCredentials);
router.get('/',getAllUsers);
router.get('/:userId', getSingleUser );
router.post('/',adduser);
router.put('/2/:name',updateUser );
router.put('/location/:name',updatUsererLoc);
router.delete('/:name',deleteUser);
// router.delete('/:userId', deleteUser );
router.put('/1/:name',updateuserimg);
router.post('/forgot-password', forgotPassword);
router.post('/deluseremail', delemail);

module.exports=router;//;