const { mongoose } = require('mongoose');

const SchemaMydoctors = mongoose.Schema({
    idPatient : {

    } ,
    Mydoctor : [
        {
         type : mongoose.Schema.Types.ObjectId
        }
    ]

})

const Mydoctor = mongoose.model('Mydoctor' , SchemaMydoctors);

module.exports = Mydoctor;