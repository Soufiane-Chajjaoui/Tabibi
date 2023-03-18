const { default: mongoose } = require('mongoose');
 

const Sous_Urgance_Schema = mongoose.Schema({

    id_Sous_Urgance : {
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
    } ,
    name_vocal : {
        type  : String ,
        require :true
    },
    id_Urgance : {
        type : String ,
        require : true
    },
    id_Response : {
        type : String ,
        require : true
    }
});

module.exports = Sous_Urgance_Schema ;
