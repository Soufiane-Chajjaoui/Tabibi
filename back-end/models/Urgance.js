const { default: mongoose } = require('mongoose');
 

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

 const Sous_urgance_Schema = mongoose.Schema({
     id_sous_Urgance : {
        type : Number ,
        require : true
     },
     libell : {
        type : String ,
        require : true
     },
     name_Image : {
        type : String ,
        require : true
     },
     id_urgance : { 
        type : String ,
        require : true 
     },
     id_reponse : {
        type : String,
        require : true
     }
 })  

 const Urgance = mongoose.model('Urgance' , Urgance_Schema) ;
 const Sous_urgance = mongoose.model('Sous_urgance' , Sous_urgance_Schema) ;

   module.exports = {Urgance , Sous_urgance} ;