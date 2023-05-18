const serworkModel = require('../models/serworkModel');

const createWork = async (req, res) => {
    const { TypeServ, Wname, Price, Hours } = req.body;
    const nework = await serworkModel.create({TypeServ, Wname, Price, Hours});
    res.json(nework);
};

const getAllworks=async(req,res)=>{
      const allWorks = await serworkModel.find();
      res.json(allWorks);
};


const getlimits = async (req, res) => {
    console.log("hi from there");
    const alltype = await serworkModel.aggregate([ 
      { "$group": { 
        _id: "$TypeServ",
        "max": { "$max": "$Price" }, 
        "min": { "$min": "$Price" } 
    }}
    ]).then(function(myDoc) {
      console.log(myDoc);
      res.json(myDoc);
    });
};

const getw = async (req, res) => {
    const TypeServ= req.params.type;
    const hours = req.params.hour.split(';');
    console.log(hours);
    const allwork = await serworkModel.find({TypeServ,Hours:{ $in: hours }}).sort( {rating: -1 }).then(function(myDoc) {
    console.log(myDoc);
    res.json(myDoc);
      });
};

const getow = async (req, res) => {
    const TypeServ= req.params.type;
    const hours = req.params.hour.split(';');
    const allwork = await serworkModel.find({TypeServ,Hours:{ $nin: hours },rating: { $gt: 3 }}).then(function(myDoc) {
    console.log(myDoc);
    res.json(myDoc);
    });
};

const deleteWork = async (req, res) => {
      console.log("hi");
      const { TypeServ, Wname } = req.body;
      const deletedServworker = await serworkModel.findOneAndDelete({ TypeServ, Wname });
    
      if (deletedServworker) {
        res.status(200).json({ message: `Servworker with TypeServ ${TypeServ} and Wname ${Wname} was deleted successfully` });
      } else {
        res.status(404).json({ message: `No servworker with TypeServ ${TypeServ} and Wname ${Wname} found` });
      }
};

const getServiceWorker = async (req, res) => {
      const { TypeServ, Wname } = req.query; // Extract TypeServ and Wname from the query parameters
      const serviceWorker = await serworkModel.findOne({ TypeServ, Wname }); // Find a service worker that matches the TypeServ and Wname
      
      // Check if a service worker was found
      if (serviceWorker) {
        res.status(200).json(serviceWorker); // Return the service worker as a JSON response
      } else {
        res.status(404).json({ message: `No servworker with TypeServ ${TypeServ} and Wname ${Wname} found` });
      }
};

const getmyService = async (req, res) => {
      const { Wname } = req.query; // Extract Wname from the query parameters
      const serviceWorkers = await serworkModel.find({ Wname }); // Find all service workers that match the Wname
      
      // Check if any service workers were found
      if (serviceWorkers.length > 0) {
        const typeServList = serviceWorkers.map(worker => worker.TypeServ); // Extract the TypeServ fields from the service workers
        res.status(200).json(typeServList); // Return the list of TypeServ fields as a JSON response
      } else {
        res.status(404).json({ message: `No servworkers found with Wname ${Wname}` });
      }
};

const updateworkerrate =async (req , res)=> {
  const  Wname  = req.query.Wname;
  const TypeServ= req.query.TypeServ;
  const { rating } = req.body.rating;
  const { timing } = req.body.timing;
  const { master } = req.body.master;
  const { behave } = req.body.behave;

  console.log(rating);
  console.log(Wname);
      
        try {
          const updUser = await serworkModel.findOneAndUpdate(
            { Wname :{$eq :Wname} , TypeServ :{$eq :TypeServ}},
            { rating:rating },
            { timing:timing },
            { master:master },
            { behave:behave },
            { new: true }
          );
          res.json(updUser);
        } catch (error) {
          res.status(500).send('Server error');
        }
};

const getSerWorker  = async (req, res) => {
      const { Wname } = req.query; 
      const serviceWorkers = await serworkModel.find({ Wname }); 
      res.json(serviceWorkers); 
};
const getSerWorkert  = async (req, res) => {
  
  const  Wname  = req.query.Wname;
  const TypeServ= req.query.TypeServ;
 // const TypeServ  = req.params.TypeServ;  
  console.log(Wname);
  const serviceWorkers = await serworkModel.find({ Wname :{$eq :Wname},TypeServ:{$eq :TypeServ} }).then(function(myDoc) {
    console.log(myDoc);
    res.json(myDoc);
    });
};
    
module.exports = {
  createWork,
  getAllworks,
  deleteWork,
  getServiceWorker,
  getmyService,
  getlimits,
  getw,
  getow,
  updateworkerrate,
  getSerWorker ,
  getSerWorkert
};