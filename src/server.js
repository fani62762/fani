const express= require('express');
const db=require('./db');


const myrouter= require('./routes/myrouter');
const app = express();
app.use(express.json());
app.use('/test',myrouter);
// app.get('/',(req,res)=>{
//     res.send('hello');
// });
app.listen(3000,()=>{
console.log('listening on port 3000')
});