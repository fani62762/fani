const servModel = require('../models/servModel');

const createserv = async (req, res) => {
    const { name, type ,avatar} = req.body;
    const newserv = await servModel.create({ name, type,avatar});
    res.json(newserv);
  };

const getAllserv= async(req,res)=>{
      const allserv = await servModel.find({}).then(function(myDoc) {
        console.log(allserv);
      res.json(myDoc);
      });
  };

const updateserv = async (req, res) =>{ 
    const {name} = req.params;
    const {type} = req.body;
    const updatedserv= await servModel.findOneAndUpdate ({name}, {type},{new:true});
    res.json (updateserv);
 };
  
const getserv = async (req, res) => {
  const type= req.params.type;
  const allserv = await servModel.find({type:type}).then(function(myDoc) {
  res.json(myDoc);
  });
 }; 
    

const deleteserv = async (req, res) =>{
    const { name } = req.params;
    const deletedserv = await servModel.findOneAndDelete({ name: name })
    res.json (deletedserv)
};

module.exports = {
    createserv,
    getAllserv,
    updateserv,
    deleteserv,
    getserv,
};


