const ordModel = require('../models/ordModel');
const fs = require('fs');

const createord = async (req, res) => {
    const { uname, TypeServ ,Wname,Price,Hour,serv,date,add,isrepeated} = req.body;
    const acc=0;
    const neword = await ordModel.create({ TypeServ ,Wname,uname, Price,Hour,serv,date,add,isrepeated,acc});
    res.json(neword);
  };

  const getorder = async (req, res) => {
    const id= req.params.id;
    const allserv = await ordModel.find({id:id}).then(function(myDoc) {
    res.json(myDoc);
    });
};

const deleteord = async (req, res) =>{
    const { id } = req.params;
    const deletedord = await ordModel.findOneAndDelete({ id: id })
    res.json (deletedord)
    };

const getworkordu = async (req, res) => {
    const Wname= req.params.name;
    const allserv = await ordModel.find({Wname,acc:{ $eq: 0 }}).then(function(myDoc) {
      console.log(myDoc);
      res.json(myDoc);
      });
  };

const getworkordd = async (req, res) => {
      const Wname= req.params.name;
      const allserv = await ordModel.find({Wname,acc:{ $eq: 1 }}).then(function(myDoc) {
      console.log(myDoc);
      res.json(myDoc);
      });
};

const  getUserordd = async (req, res) => {
    const uname= req.params.name;
    const allserv = await ordModel.find({uname,acc:{ $eq: 2 }}).then(function(myDoc) {
    console.log(myDoc);
    res.json(myDoc);
    });
};
const  getUserordc = async (req, res) => {
  const uname= req.params.name;
  const allserv = await ordModel.find({uname,acc:{ $eq: -2 }}).then(function(myDoc) {
  console.log(myDoc);
  res.json(myDoc);
  });
};

const  getUserordu = async (req, res) => {
    const uname= req.params.name;
    const allserv = await ordModel.find({uname,acc:{ $eq: 1 }}).then(function(myDoc) {
    console.log(myDoc);
    res.json(myDoc);
    });
};

// const updateaccw= async (req,res)=>{
//   const  id  = req.params.id;
//   const { acc} = req.body;
//   console.log(id);
//   try {
//     const updUser = await ordModel.findByIdAndUpdate(
//       id,
//       { acc :acc },
//       { new: true }
//     );
//     res.json(updUser);
//   } catch (error) {
//     res.status(500).send('Server error');
//   }
// }
const updateaccw= async (req,res)=>{
  const id  = req.params.id;
  const acc = req.body.acc;
  console.log(id);
  console.log(acc);
  try {
    const updUser = await ordModel.findByIdAndUpdate(
      id ,
      { acc },
      { new: true }
    );
    res.json(updUser);
  } catch (error) {
    res.status(500).send('Server error');
  }
}

const updateaccu= async (req,res)=>{
  const { id } = req.params.id;
  const { acc} = req.body;
  try {
    const updUser = await ordModel.findOneAndUpdate(
      { id },
      { acc },
      { new: true }
    );
    res.json(updUser);
  } catch (error) {
    res.status(500).send('Server error');
  }
}

  module.exports = {
    getorder , 
    createord,
    deleteord,
    getworkordu,
    getworkordd,
    getUserordd,
    getUserordu,
    updateaccw,
    updateaccu,
    getUserordc,

};