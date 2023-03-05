const extendSchema = require('mongoose-extend-schema');
const { default: mongoose } = require('mongoose');
const {Doctor, Patient} = require('./models/Person_Model') ;
const { ObjectId} = require('mongodb')
const express  = require('express') ;
const cors = require('cors') ;
const bodyParse = require('body-parser') ;
const app = express() ;
 require('dotenv').config() ;

const router = require('./routes/router')

const port = 8080 || process.env.port ;


mongoose.set('strictQuery', true);

mongoose.connect("mongodb+srv://soufian_node:soufianch@testnode.fblmhkz.mongodb.net/project_pfe?retryWrites=true&w=majority", {
    useNewUrlParser : true ,
    useUnifiedTopology : true 
}) .then(() => app.listen(port))
 .catch((error) => {
   console.error('Error connecting to database: ', error);
 });

 
//Middlware
app.use(cors()) ; 
app.use(bodyParse.urlencoded({extended : true})) ;
app.use(bodyParse.json()) ;
app.use('/' , router) ;



