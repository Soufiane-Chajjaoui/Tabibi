const mongoose = require('mongoose');


const Schema_reponse = mongoose.Schema({

    id_reponse : {
        type : Number ,
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
    },
    description : { 
        type : String ,
        require : true
    },
    
});
 const Reponse = mongoose.model('Reponse' , Schema_reponse)
module.exports = {Reponse , Schema_reponse} ;