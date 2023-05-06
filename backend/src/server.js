const express = require('express'); //import
const db=require('./db');

const userRouter=require('./routes/userRouter');
const workerRouter=require('./routes/workerRouter');
const serworkRouter=require('./routes/serworkRouter');
const servRouter=require('./routes/servRouter');
const typeRouter=require('./routes/typeRouter');
const ordRouter=require('./routes/ordRouter');
const adminRouter=require('./routes/adminRouter');
const app=express();

app.use(express.json());
app.use('/users',userRouter);
app.use('/worker',workerRouter);
app.use('/servwork',serworkRouter);
app.use('/serv',servRouter);
app.use('/type',typeRouter);
app.use('/ord',ordRouter);
app.use('/admin',adminRouter);

var port =process.env.PORT || 3000;
app.listen(port,()=>{
    console.log(" Listening on port");
    console.log(port);
});
exports=app;


