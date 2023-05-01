const extendSchema = require('mongoose-extend-schema');
const { default: mongoose } = require('mongoose');
const {Doctor, Patient} = require('./models/Person_Model') ;
const Sous_urgance = require('./models/SousUrgance') ;
const { ObjectId} = require('mongodb');
const favicon = require('serve-favicon') ;
const express  = require('express') ;
const path = require('path') ;
const ejs = require('ejs');
const cors = require('cors') ;
const bodyParse = require('body-parser') ;
const app = express()  ;
require('dotenv').config() ;
const session = require('express-session');
// const {checkSessionExpiration} = require('./Middelware/checkSession') ;
const router = require('./routes/router');
// const fileUpload = require('express-fileupload');

const port = 8080 || process.env.port ;


mongoose.set('strictQuery', true);
// mongoose.disconnect(); disconnect connection with DATABASE 
mongoose.connect("mongodb+srv://soufian_node:soufianch@testnode.fblmhkz.mongodb.net/project_pfe?retryWrites=true&w=majority", {
    useNewUrlParser : true ,
    useUnifiedTopology : true , 
    dbName : 'project_pfe'
}) .then(() => app.listen(port , ()=> {
  console.log('http://localhost:'+port)
}))
 .catch((error) => {
   console.error('Error connecting to database: ', error);
 }); 

  
//Middlware

app.use('/', express.static('uploads'));
app.use(session({
  secret: 'mysecretkey', // set a secret key
  resave: false, // don't save session if unmodified
  saveUninitialized: false , // don't create session until something stored
  // cookie: { maxAge: new Date(Date.now() + 60000) } // 1 minute
}));
// app.use((req,res,next)=>{
//   if (req.session.username && req.session) {
//     res.redirect('/admin/dashboard') ;
//     next() ;
//   }else {res.redirect('../register') ;}
// })
// app.use(fileUpload({
//   useTempFiles : true,
// }));
app.use(express.static('public'));
app.use(favicon(path.join(__dirname , 'public' , '/assets/logo_tabibi.png')));
app.use(cors()) ;  
app.use(bodyParse.urlencoded({extended : true , limit: '25mb'})) ;
app.set('view engine','ejs') ;
app.use(bodyParse.json({limit: '25mb'})) ;
app.use('/' , router) ; 
 



