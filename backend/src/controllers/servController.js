const servModel = require('../models/servModel');

const createserv = async (req, res) => {
    const { name, type ,avatar} = req.body;
    const newserv = await servModel.create({ name, type,avatar});
    res.json(newserv);
  };
  const createservt = async (req, res) => {
    
    const { name,type} = req.body;
    const newserv = await servModel.create({ name, type});
    res.json(newserv);
  };

const getAllserv= async(req,res)=>{
      const allserv = await servModel.find({}).then(function(myDoc) {
        console.log(allserv);
      res.json(myDoc);
      });
  };
  const getAllservo = async (req, res) => {
    try {
      const allserv = await servModel.find({}).sort({ type: 1 });
      console.log(allserv);
      res.json(allserv);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Internal Server Error' });
    }
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
 const getAllservn = async (req, res) => {
  const type= req.params.type;
  const allserv = await servModel.find({name:name}).then(function(myDoc) {
  res.json(myDoc);
  });
 }; 
 

    

const deleteserv = async (req, res) =>{
    const { name } = req.params;
    const deletedserv = await servModel.findOneAndDelete({ name: name })
    res.json (deletedserv)
};

const deleteServicesByType = async (req, res) => {
  const { type } = req.params; // Assuming the type is provided in the URL parameters
  
  try {
    const deletedServices = await servModel.deleteMany({ type });
    res.json({ message: `Deleted ${deletedServices.deletedCount} services with type '${type}'` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

module.exports = {
    deleteServicesByType,
    createserv,
    getAllserv,
    updateserv,
    deleteserv,
    getserv,
    //getAllservt,
    getAllservn,
    getAllservo,
    createservt,
};


