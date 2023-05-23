const mongoose = require('mongoose');


const Schema_reponse = mongoose.Schema({

    id_reponse : {
        type : Number ,
    },
    name_Image : {
        public_id :String ,
        url  :  String ,
        },
     
    description : { 
        type : String ,
    },
    moreDetails : {
        details : String ,
        // name_Image : {
        //     public_id : String ,
        //         url : String ,
        //        }
        },
 
    
});
 const Reponse = mongoose.model('Reponse' , Schema_reponse)
module.exports = {Reponse , Schema_reponse} ;