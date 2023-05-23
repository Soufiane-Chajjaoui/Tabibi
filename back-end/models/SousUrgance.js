const { default: mongoose } = require('mongoose');
 const {Schema_Sous_Sous_Urgance} = require('./SousSousUrgance');
const Sous_Urgance_Schema = mongoose.Schema({

    id_Sous_Urgance : {
        type : Number ,
        require : true
    },
    libell : {
        type : String ,
        require : true
    },
    sous_sous_urgance : [ Schema_Sous_Sous_Urgance ] ,
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
    // name_vocal : {
    //     type  : String ,
    //     require :true
    // },
    // id_Urgance :  {
    //     id_urg : String ,
    //     libell_urg : String}
      
    
});
const Sous_urgance = mongoose.model('Sous_urgance' , Sous_Urgance_Schema )
module.exports = {Sous_urgance , Sous_Urgance_Schema} ;
