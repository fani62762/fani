const ordModel = require('../models/ordModel');
const fs = require('fs');

const createord = async (req, res) => {
    const { uname, TypeServ ,Wname,Price,Hour,serv,date,add,isrepeated} = req.body;
    const acc=0;
   console.log(uname);
    const neword = await ordModel.create({ TypeServ ,Wname,uname, Price,Hour,serv,date,add,isrepeated,acc});
    res.json(neword);
    console.log(neword);
  };

  const getorder = async (req, res) => {
    const id= req.params.id;
    const allserv = await ordModel.find({id:id}).then(function(myDoc) {
    res.json(myDoc);
    });
};
//getallorder
const getallorder = async (req, res) => {
 
  const allserv = await ordModel.find({}).then(function(myDoc) {
    console.log(myDoc);
  res.json(myDoc);
  });
};
const deleteordsworker = async (req, res) => {
  const { Wname } = req.params;

  try {
    const deletedOrders = await ordModel.deleteMany({ Wname: Wname });
    res.json({ message: 'Orders deleted successfully' });
    console.log(Wname);
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete orders', message: error.message });
  }
};
const deleteordsusers = async (req, res) => {
  const { uname } = req.params;

  try {
    const deletedOrders = await ordModel.deleteMany({ uname: uname });
    res.json({ message: 'Orders deleted successfully' });
    console.log(uname);
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete orders', message: error.message });
  }
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
  const getworkordc = async (req, res) => {
    const Wname= req.params.name;
    const allserv = await ordModel.find({Wname,acc:{ $eq: 2 }}).then(function(myDoc) {
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
const  getUserordw = async (req, res) => {
  const uname= req.params.name;
  const allserv = await ordModel.find({uname,acc:{ $eq: 0 }}).then(function(myDoc) {
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

const  getUserordwork = async (req, res) => {
  const uname= req.params.uname;
  const Wname= req.params.Wname;
  
  const allserv = await ordModel.find({uname,Wname}).then(function(myDoc) {
  console.log(myDoc);
  res.json(myDoc);
  });
};

const  getUserord = async (req, res) => {
  const uname= req.params.uname;
 
  
  const allserv = await ordModel.find({uname}).then(function(myDoc) {
  console.log(myDoc);
  res.json(myDoc);
  });
};
const  getworkord = async (req, res) => {
  const Wname= req.params.Wname;
 
  
  const allserv = await ordModel.find({Wname}).then(function(myDoc) {
  console.log(myDoc);
  res.json(myDoc);
  });
};

const retrieveUnamesByWorker = async (req, res) => {
  const { Wname } = req.params;

  try {
    const orders = await ordModel.find({ Wname: Wname });
    const unames = [...new Set(orders.map(order => order.uname))];

    res.json(unames);
  } catch (error) {
    res.status(500).send('Server error');
  }
};
const retrieveWorkerssByuname = async (req, res) => {
  const { uname } = req.params;

  try {
    const orders = await ordModel.find({ uname: uname });
    const wnames = [...new Set(orders.map(order => order.Wname))];

    res.json(wnames);
  } catch (error) {
    res.status(500).send('Server error');
  }
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
const updaterate= async (req,res)=>{
  const { id } = req.params.id;
  const { rating } = req.body;
  try {
    const updUser = await ordModel.findOneAndUpdate(
      { id },
      { rating },
      { new: true }
    );
    res.json(updUser);
  } catch (error) {
    res.status(500).send('Server error');
  }
}
const getOrdersCountByMonth = async (req, res) => {
  console.log("hi");
  try {
    const orders = await ordModel.find();
    const ordersCountByMonth = {};

    orders.forEach(order => {
      const date = new Date(Date.parse(order.date));
      const month = date.getMonth() + 1; // Add 1 because month index starts from 0
      const monthKey = `${month}`;

      if (ordersCountByMonth.hasOwnProperty(monthKey)) {
        ordersCountByMonth[monthKey]++;
      } else {
        ordersCountByMonth[monthKey] = 1;
      }
    });

    res.json(ordersCountByMonth);
  } catch (error) {
    res.status(500).send('Server error');
  }
};
const getOrdersCountByDay = async (req, res) => {
  try {
    const orders = await ordModel.find();
    const ordersCountByDay = {};

    // Initialize the ordersCountByDay object with all days set to 0
    const dayAbbreviations = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    dayAbbreviations.forEach(dayAbbreviation => {
      ordersCountByDay[dayAbbreviation] = 0;
    });

    orders.forEach(order => {
      const date = new Date(Date.parse(order.date));
      const day = date.getDay(); // Get the day of the week (0 - Sunday, 1 - Monday, etc.)
      const dayAbbreviation = getDayAbbreviation(day); // Function to get the day abbreviation from the day index

      ordersCountByDay[dayAbbreviation]++;
    });

    res.json(ordersCountByDay);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

// Function to get the day abbreviation from the day index (0 - Sunday, 1 - Monday, etc.)
const getDayAbbreviation = (dayIndex) => {
  const dayAbbreviations = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return dayAbbreviations[dayIndex];
};

const getOrdersCountWByDay = async (req, res) => {
  const { Wname } = req.params;
  try {
    const orders = await ordModel.find({ Wname: Wname });
    const ordersCountByDay = {};

    // Initialize the ordersCountByDay object with all days set to 0
    const dayAbbreviations = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    dayAbbreviations.forEach(dayAbbreviation => {
      ordersCountByDay[dayAbbreviation] = 0;
    });

    orders.forEach(order => {
      const date = new Date(Date.parse(order.date));
      const day = date.getDay(); // Get the day of the week (0 - Sunday, 1 - Monday, etc.)
      const dayAbbreviation = getDayAbbreviation(day); // Function to get the day abbreviation from the day index

      ordersCountByDay[dayAbbreviation]++;
    });

    res.json(ordersCountByDay);
  } catch (error) {
    res.status(500).send('Server error');
  }
};



const getOrderCountsByService = async (req, res)=> {
  try {
   const orderCountsByService = await ordModel.aggregate([
     {
       $group: {
         _id: '$TypeServ',
         count: { $sum: 1 }
       }
     }
   ]);

   res.json(orderCountsByService);
 } catch (error) {
   res.status(500).json({ error: 'Failed to retrieve order counts by service' });
 };
}

const getOrderCountsWByService = async (req, res) => {
  const { Wname } = req.params;
  try {
    const orderCountsByService = await ordModel.aggregate([
      {
        $match: { Wname: Wname }
      },
      {
        $group: {
          _id: '$TypeServ',
          count: { $sum: 1 }
        }
      }
    ]);

    res.json(orderCountsByService);
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve order counts by service' });
  }
};


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
    getOrdersCountByMonth,
    getOrdersCountByDay,
    getOrderCountsByService,
    getUserordwork,
    getUserord,
    getallorder,
    getworkord,
    deleteordsworker,
    deleteordsusers,
    retrieveUnamesByWorker,
    retrieveWorkerssByuname,
    getOrdersCountWByDay,
    getOrderCountsWByService,
    getworkordc,
    updaterate,
    getUserordw



};