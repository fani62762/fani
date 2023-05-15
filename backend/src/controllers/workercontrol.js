const workerModel= require('../models/workermodel');
const nodemailer = require('nodemailer');

const forgotPassword = async (req, res) => {
  const { name } = req.body;
  try {
    const wor = await workerModel.findOne({ name });
    if (!wor) {
      return res.status(404).json({ message: 'هذا الاسم غير مسجل بالنظام' });
    }
    // Generate a random password with 6 characters, including letters and digits
    const resetCode = Math.random().toString(36).slice(-6);
    console.log(resetCode);
    wor.password = resetCode;
    await wor.save();

    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "fani62762@gmail.com",
        pass: "kuuhbddzrzwtfpnd"
      }
    });

    const mailOptions = {
      to: wor.email,
      from:"fani62762@gmail.com",
      subject: 'طلب كلمة سر جديدة',
     text:`${resetCode} كلمة السر الجديدة الخاصة بك هي \n يرجى الدخول الى تعديل الصفحة الشخصية الخاص بك لتحديث كلمتك السرية  `,
      // html: `يرجى الدخول الى تعديل الصفحة الشخصية الخاص بك لتحديث كلمتك السرية.<b>كلمة السر الجديدة الخاصة بك هي: ${resetCode}</b>`
    };

    await transporter.sendMail(mailOptions);

    res.status(200).json({ message: `يرجى التحقق من بريدك الإلكتروني ${wor.email} \nللحصول على التعليمات \n ` });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err });
  }
};

const addworker= async (req,res) => {
    const {name,password,email,gender,phone,date}=req.body;
    const newworker= await workerModel.create({name,password,email,gender,phone,date});
    res.json(newworker);
};

const getallworker= async (req,res) =>{
    const allworker= await workerModel.find();
    res.json(allworker);
};

const submitCredentials = async (req, res) => {
  const { name, password } = req.body;
  try {
    const wor = await workerModel.findOne({ name });
    if (!wor) {
      return res.status(401).json({ message: 'Invalid nameW' });
    }
    const isMatch = await workerModel.findOne({ name, password });
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid passwordW' });
    }
    return res.status(200).json({ message: 'Success' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'An error occurred while trying to log in. Please try again later.' });
  }
};

const updateworkerimg =async (req , res)=> {
  const { name } = req.params;
    const { image } = req.body;
    try {
      const updwor = await workerModel.findOneAndUpdate(
        { name },
        { image:image },
        { new: true }
      );
      res.json(updwor);
    } catch (error) {
      res.status(500).send('Server error');
    }
};

const updateworkerrate =async (req , res)=> {
  const { name } = req.params;
    const { rating } = req.body;
    try {
      const updwor = await workerModel.findOneAndUpdate(
        { name },
        { rating:rating },
        { new: true }
      );
      res.json(updwor);
    } catch (error) {
      res.status(500).send('Server error');
    }
};

const updateworkerbio =async (req , res)=> {
    const { name } = req.params;
      const { bio } = req.body;
      try {
        const updwor = await workerModel.findOneAndUpdate(
          { name },
          { bio:bio },
          { new: true }
        );
        res.json(updwor);
      } catch (error) {
        res.status(500).send('Server error');
      }
};
  
const updateworker= async (req,res)=>{
  const { name } = req.params;
  const { password, email, gender, phone, date,address } = req.body;
  try {
    const updwor = await workerModel.findOneAndUpdate(
      { name },
      { password, email, gender, phone, date,address },
      { new: true }
    );
    res.json(updwor);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

const updateworkerLoc= async (req,res)=>{
  const { name } = req.params;
  const { address,latitude,longitude } = req.body;
  try {
    const updwor = await workerModel.findOneAndUpdate(
      { name },
      { address,latitude,longitude },
      { new: true }
    );
    res.json(updwor);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

const getsingleworker = async (req,res)=>{
  const {worId}=req.params;
  const singleworker= await workerModel.findById(worId);
  res.json(singleworker);
};

const getworker = async (req, res) => {
  try {
    const name = req.params.name;
    const worker = await workerModel.findOne({ name: name });
    if (worker) {
      res.status(200).json(worker);
    } else {
      res.status(404).json({ error: 'worker not found' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

const deleteworker = async (req,res)=>{
    const {name}=req.params;
    const deletedworker=await workerModel.findOneAndDelete({"name": name});
    res.json(deletedworker);
};


module.exports={
    addworker,
    getallworker,
    updateworkerimg,
    updateworker,
    updateworkerLoc,
    getsingleworker,
    deleteworker,
    submitCredentials,
    getworker,
    updateworkerrate,
    updateworkerbio,
    forgotPassword
};