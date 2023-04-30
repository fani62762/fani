

const typeModel = require('../models/typeModel');
const fs = require('fs');

const createtype = async (req, res) => {
    const {  type ,avatar} = req.body;
    const newtype = await typeModel.create({  type,avatar});
    res.json(newtype);
};

const updatetype = async (req, res) =>{ 
    const {type} = req.params;
    const {avatar} = req.body;
    const updatedtype= await typeModel.findOneAndUpdate ({type}, {avatar},{new:true});
    res.json (updatedtype);
};
  
const gettype = async (req, res) => {
  const type= req.params.type;
  const alltype = await typeModel.find({type:type}).then(function(myDoc) {
  res.json(myDoc);
});
}; 

const alltypes= async (req,res) =>{
    const allt= await typeModel.find();
    res.json(allt);
};

const getAlltype = async (req, res) => {
    const allserv = await typeModel.find().then(function(myDoc) {
    res.json(myDoc);
    });
};

const deletetype = async (req, res) =>{
    const { type } = req.params;
    const deletedtype = await typeModel.findOneAndDelete({ type: type})
    res.json (deletedtype)
};

module.exports = {
    createtype,
    updatetype,
    deletetype,
    gettype,
    getAlltype,
    alltypes
};