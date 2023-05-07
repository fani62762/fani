const express=require('express');
const cors = require('cors');
const {forgotPassword ,submitCredentials,updateAdmin, getAdmin, updateadminimg} =require('../controllers/adminControl');
const adminrouter=express.Router()
adminrouter.use(cors());
adminrouter.get('/',getAdmin);
adminrouter.post('/login',submitCredentials);
adminrouter.put('/2/:name',updateAdmin );
adminrouter.put('/1/:name',updateadminimg);
adminrouter.post('/forgot-password', forgotPassword);

module.exports=adminrouter;