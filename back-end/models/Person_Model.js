 const { default: mongoose } = require('mongoose');
 const extendSchema = require('mongoose-extend-schema');

   /*+++++++++++++++++++++++++++++++++++ Person Schema Model Parent +++++++++++++++++++++++++++++++++++++++*/

const PersonSchema = new mongoose.Schema({
    id : {
      type : Number ,
      require : true
  } ,
  CNI : {
      type : String ,
      require : true
   },
  complete_name : {
      type : String ,
      require : true
  },
  num_tele : {
      type : Number ,
      require : true
  },
  password : {
      type : String ,
      require : true
  },
  gender  : {
      type : String ,
      enum : ['Male' , 'Female']
  } ,

  });

   /*+++++++++++++++++++++++++++++++++++ Doctor Schema parent +++++++++++++++++++++++++++++++++++++++*/
   const DoctorSchema =  extendSchema(PersonSchema, {
    mail : {
      type : String ,
      require : true
  },
  speciality : {
      type : String ,
      require : true 
  } ,
  } ,{timestamps : true});
   /*+++++++++++++++++++++++++++++++++++ Patient Schema Child +++++++++++++++++++++++++++++++++++++++*/
  const PatientSchema = extendSchema(PersonSchema , {
    avatar : {
        type : String 
      }
  } , {timestamps : true}) ;

  const Person = mongoose.model('Person',PersonSchema)
  const Doctor = mongoose.model('Doctor',DoctorSchema)
  const Patient = mongoose.model('Patient' , PatientSchema)


  module.exports = { Doctor , Patient} ;