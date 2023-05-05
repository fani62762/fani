const AdminModel = require('../models/adminModel');
const nodemailer = require('nodemailer');

const forgotPassword = async (req, res) => {
  const { name } = req.body;
  try {
    const use = await AdminModel.findOne({ name });
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

const submitCredentials = async (req, res) => {
  const { name, password } = req.body;
  try {
    const user = await AdminModel.findOne({ name });
    if (!user) {
      return res.status(401).json({ message: 'Invalid nameAdmin' });
    }
    const isMatch = await AdminModel.findOne({password});
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid passwordAdmin' });
    }
    return res.status(200).json({ message: 'Success' });

  } catch (error) {
    return res.status(500).json({ message: 'An error occurred while trying to log in. Please try again later.' });
  }
};

const updateAdmin= async (req,res)=>{
  const { name } = req.params;
  const { password, email, gender, phone} = req.body;
  try {
    const updUser = await AdminModel.findOneAndUpdate(
      { name },
      { password, email, gender, phone },
      { new: true }
    );

    res.json(updUser);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
};

const getAdmin = async (req, res) => {
  try {
    const { name } = req.params;
    const singleUser = await AdminModel.findById(name);
    if (!singleUser) {
      return res.status(404).json({ error: 'Admin not found' });
    }
    res.json(singleUser);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
};
  

const updateadminimg =async (req , res)=> {
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

module.exports = {
  forgotPassword ,
  submitCredentials,
  updateAdmin,
  getAdmin,
  updateadminimg
};