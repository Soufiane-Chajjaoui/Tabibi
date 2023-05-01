
const mongoose = require('mongoose') ;



const SchemaDemand = new mongoose.Schema({

            idPatient : {
                type : mongoose.ObjectId,
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
            ,
            createAt : {
                type : Date ,
                default: new Date()
            } , 
        }
    )

    const Demand = mongoose.model('Demand' , SchemaDemand) ;

    module.exports = {Demand} ;