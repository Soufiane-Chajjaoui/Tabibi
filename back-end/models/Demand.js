
const mongoose = require('mongoose') ;



const SchemaDemand = new mongoose.Schema({

    idPatient : {
        type : String ,
        require : true
    } ,
    accepted : {
        type : Boolean ,
        require : true ,
        default : false
    },
    Urgance_name : {
        type : String ,
        require : true
    }
    } , {timestamps : true})

    const Demand = mongoose.model('Invitation' , SchemaDemand) ;

    module.exports = Demand ;