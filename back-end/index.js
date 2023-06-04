const extendSchema = require('mongoose-extend-schema');
 const {Doctor, Patient} = require('./models/Person_Model') ;
const Sous_urgance = require('./models/SousUrgance') ;
const favicon = require('serve-favicon') ;
const express  = require('express') ;
const cookiesParser = require('cookie-parser');
const path = require('path') ;
const ejs = require('ejs');
const cors = require('cors') ;
const firebase = require('firebase-admin');
const mongoose = require('mongoose');
const bodyParse = require('body-parser') ;
const {db} = require('./Tools/Firebase'); 
const app = express()  ;
const http = require('http') ;
const server = http.createServer(app) ;
const { Server } = require('socket.io') ;
const io = new Server(server) ; 
 require('dotenv').config({path : path.join(__dirname, './.env')});
const session = require('express-session');
// const {checkSessionExpiration} = require('./Middelware/checkSession') ;
const router = require('./routes/router');
const routerFirebase = require('./routes/routerFirebase');
const { AuthCurrent } = require('./middleware/Auth');
 
const port = process.env.Port  || 8080 ;

var client = {} ;
io.on('connection', (socket) => {
  let UserId = socket.handshake.query.idSender ;
  client[UserId] = socket ;
  console.log("connect :" , UserId);
  socket.on('/message' , (message) => {
    console.log(message) ;
     if (client[message.idReceiver]) {     
      client[message.idReceiver].emit('/receive', message);
    }else {

    }
     
  })
});

mongoose.set('strictQuery', true);
// mongoose.disconnect(); disconnect connection with DATABASE 

mongoose.connect("mongodb+srv://soufian_node:soufianch@testnode.fblmhkz.mongodb.net/project_pfe?retryWrites=true&w=majority", {
    useNewUrlParser : true ,
    useUnifiedTopology : true , 
    dbName : 'project_pfe'
}) .then(() => {
  if (mongoose.connection.readyState === 1) {
    server.listen(port, "192.168.1.3" ,() => {
      console.log('http://localhost:' + port);
    });
  } else {
    console.error('Error connecting to database: Connection not established.');
    return res.status(500).json({ error: 'Server failed to connect to the database.' });
  }
})
.catch((error) => {
  console.error('Error connecting to database:', error);
  return res.status(500).json({ error: 'Server failed to connect to the database.' });
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
app.use(cookiesParser())


app.get("*" , AuthCurrent ); 
app.use('/' , router) ; 
app.use('/users' , routerFirebase) ; 

 



