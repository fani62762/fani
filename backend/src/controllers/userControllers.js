const UserModel = require('../models/userModel');
const nodemailer = require('nodemailer');

const forgotPassword = async (req, res) => {
  const { name } = req.body;
  try {
    const use = await UserModel.findOne({ name });
    if (!use) {
      return res.status(404).json({ message: 'هذا الاسم غير مسجل بالنظام' });
    }
    // Generate a random password with 6 characters, including letters and digits
    const resetCode = Math.random().toString(36).slice(-6);
    console.log(resetCode);
    use.password = resetCode;
    await use.save();

    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "fani62762@gmail.com",
        pass: "kuuhbddzrzwtfpnd"
      }
    });

    const mailOptions = {
      to: use.email,
      from:"fani62762@gmail.com",
      subject: 'طلب كلمة سر جديدة',
     text:`${resetCode} كلمة السر الجديدة الخاصة بك هي \n يرجى الدخول الى تعديل الصفحة الشخصية الخاص بك لتحديث كلمتك السرية  `,
      // html: `يرجى الدخول الى تعديل الصفحة الشخصية الخاص بك لتحديث كلمتك السرية.<b>كلمة السر الجديدة الخاصة بك هي: ${resetCode}</b>`
    };

    await transporter.sendMail(mailOptions);

    res.status(200).json({ message: `يرجى التحقق من بريدك الإلكتروني ${use.email} \nللحصول على التعليمات \n ` });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err });
  }
};
const delemail = async (req, res) => {
  const { name } = req.body;
  try {
    const use = await UserModel.findOne({ name });
    if (!use) {
      return res.status(404).json({ message: 'هذا الاسم غير مسجل بالنظام' });
    }
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
      subject: 'حذف حساب',
     text:` للأسف تم حذف حسابك من تطبيق فني \n من خلال الادمين \n لأي استفسار تواصل من خلال هذا الايميل  `,
      // html: `يرجى الدخول الى تعديل الصفحة الشخصية الخاص بك لتحديث كلمتك السرية.<b>كلمة السر الجديدة الخاصة بك هي: ${resetCode}</b>`
    };

    await transporter.sendMail(mailOptions);
    res.status(200).json({ message: `تم الارسال الى البريد الإلكتروني ${use.email}` });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err });
  }
};
const adduser= async (req,res) => {
  const pref ="m,t,d,p,b";
  const {name,password,email,gender,phone,date}=req.body;
  const newworker= await UserModel.create({name,password,email,gender,phone,date,pref});
  res.json(newworker);
};

const getAllUsers=async(req,res)=>{
    const allUsers = await UserModel.find();
    res.json(allUsers);
};

const submitCredentials = async (req, res) => {
  const { name, password } = req.body;
  try {
    const user = await UserModel.findOne({ name });
    if (!user) {
      return res.status(401).json({ message: 'Invalid nameU' });
    }
    const isMatch = await UserModel.findOne({ name, password });
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid passwordU' });
    }
    return res.status(200).json({ message: 'Success' });
  } catch (error) {
    return res.status(500).json({ message: 'An error occurred while trying to log in. Please try again later.' });
  }
};

const updateUser= async (req,res)=>{
  const { name } = req.params;
  const { password, email, gender, phone, date,address, pref} = req.body;
  try {
    const updUser = await UserModel.findOneAndUpdate(
      { name },
      { password, email, gender, phone, date,address,pref },
      { new: true }
    );

    res.json(updUser);
    console.log(updUser);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
};

const updatUsererLoc= async (req,res)=>{
  const { name } = req.params;
  const { address,latitude,longitude } = req.body;
  try {
    const updus = await UserModel.findOneAndUpdate(
      { name },
      { address,latitude,longitude },
      { new: true }
    );
    res.json(updus);
  } catch (error) {
    res.status(500).send('Server error');
  }
};

const getSingleUser = async (req, res) => {
    const { userId } = req.params;
    const singleUser = await UserModel.findById(userId);
    res.json (singleUser);
};  

const getUser = async (req, res) => {
      try {
        const name = req.params.name;
        const user = await UserModel.findOne({ name: name });
        if (user) {
          res.status(200).json(user);
        } else {
          res.status(404).json({ error: 'User not found' });
        }
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Server error' });
      }
}; 

const gendercount = async (req, res) => {
  try {
    const ug = await UserModel.find();
    const femaleCount= ug.filter(worker => worker.gender === 'أنثى').length;
    const maleCount  = ug.filter(worker => worker.gender === 'ذكر').length;

    res.json({
      maleCount: maleCount,
      femaleCount: femaleCount
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to retrieve genderuser' });
  }
};

// const deleteUser = async (req, res) =>{
//     const { userId } = req.params;
//     const deleteduser = await UserModel.findByIdAndDelete (userId)
//     res.json (deleteduser)
// };

const updateuserimg =async (req , res)=> {
      const { name } = req.params;
        const { image } = req.body;
        try {
          const updUser = await UserModel.findOneAndUpdate(
            { name },
            { image:image },
            { new: true }
          );
          res.json(updUser);
        } catch (error) {
          res.status(500).send('Server error');
        }
}; 
const deleteUser = async (req,res)=>{
  const {name}=req.params;
  const deletedworker=await UserModel.findOneAndDelete({"name": name});
  res.json(deletedworker);
};

module.exports = {
    adduser,
    updateuserimg,
    getAllUsers,
    updateUser,
    getSingleUser,
    deleteUser,
    getUser,
    submitCredentials,
    forgotPassword,
    updatUsererLoc,
    gendercount,
    delemail
};