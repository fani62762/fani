const userModel= require('../models/workermodel');

const adduser= async (req,res) => {
    const {username,password,email,gender,phone,dateofbirth}=req.body;

    const newuser= await userModel.create({username,password,email,gender,phone,dateofbirth});
    res.json(newuser);
};

const getallUser= async (req,res) =>{
    const alluser= await userModel.find();
    res.json(alluser);
}

const updateuser= async (req,res)=>{
    const {name}=req.params;
    const {username,password,email,gender,phone,dateofbirth}=req.body;
    const updateduser=await userModel.findOneAndUpdate({"username": name},
   { username,password,email,gender,phone,dateofbirth,},
    {new :true},
    );
    res.json(updateduser);
}

const getsingleuser = async (req,res)=>{
    const {name}=req.params;
    const singleuser= await userModel.findOne({"username": name});
    res.json(singleuser);
}

const deleteuser = async (req,res)=>{
    const {name}=req.params;
   
    const deleteduser=await userModel.findOneAndDelete({"username": name});
    res.json(deleteduser);
}
module.exports={
    adduser,
    getallUser,
    updateuser,
    getsingleuser,
    deleteuser,

};