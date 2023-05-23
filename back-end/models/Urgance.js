const { default: mongoose } = require('mongoose');
const {Sous_Urgance_Schema} = require('../models/SousUrgance') ;
 

   /*+++++++++++++++++++++++++++++++++++ Urgance Schema +++++++++++++++++++++++++++++++++++++++*/

   const Urgance_Schema = mongoose.Schema(
    {
        id_Urgance : {
            type : Number ,
            require : true
        },
        libell : {
            type : String ,
            require : true
        },
        Sous_urgance : [Sous_Urgance_Schema] ,
           
        name_Image : {
         public_id : {
            type : String ,
            require : true
           } ,
           url  : {
            type : String ,
            require : true
           }
        } ,
       
    }
   );



 const Urgance = mongoose.model('Urgance' , Urgance_Schema) ;
 
   module.exports = { Urgance } ;