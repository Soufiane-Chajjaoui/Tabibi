
const mongoose = require('mongoose') ;
const PatientSchema = require('./Person_Model');


const SchemaDemand = new mongoose.Schema({

            idPatient : {
                type: mongoose.Schema.Types.ObjectId,
                ref: 'Patient',
                require : true
            } ,
            accepted : {
                type : Boolean ,
                require : true ,
                default : false
            },

     
        } ,{timestamps : true}
    );
 

SchemaDemand.pre('save', async function (next) {
  try {
    const existingDemand = await Demand.findOne({ idPatient: this.idPatient });
    if (existingDemand) {
      throw new Error('You have already sent a request. Please wait a response.');
    }
    next();
  } catch (err) {
    next(err);
  }
});

 

    const Demand = mongoose.model('Demand' , SchemaDemand) ;

    module.exports = {Demand} ;