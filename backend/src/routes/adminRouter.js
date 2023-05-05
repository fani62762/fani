const express=require('express');
const {   forgotPassword ,submitCredentials,updateAdmin, getAdmin, updateadminimg} = require('../controllers/adminControllers');

const adminrouter=express.Router()

adminrouter.get('/2/:name',getAdmin);
adminrouter.post('/login',submitCredentials);
adminrouter.put('/2/:name',updateAdmin );
adminrouter.put('/1/:name',updateadminimg);
adminrouter.post('/forgot-password', forgotPassword);

module.exports=adminrouter;//;