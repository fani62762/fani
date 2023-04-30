const express=require('express');
const { createUser,forgotPassword, getAllUsers,submitCredentials,updateuserimg,updatUsererLoc, updateUser, deleteUser, getSingleUser, getUser } = require('../controllers/userControllers');

const router=express.Router()

router.get('/1/:userId', getSingleUser );
router.get('/2/:name',getUser);
router.post('/login',submitCredentials);
router.get('/',getAllUsers);
router.get('/:userId', getSingleUser );
router.post('/',createUser);
router.put('/2/:name',updateUser );
router.put('/location/:name',updatUsererLoc);
router.delete('/:userId', deleteUser );
router.put('/1/:name',updateuserimg);
router.post('/forgot-password', forgotPassword);

module.exports=router;//;