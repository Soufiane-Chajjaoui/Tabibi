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

   /*+++++++++++++++++++++++++++++++++++ Doctor Schema Child +++++++++++++++++++++++++++++++++++++++*/
   const DoctorSchema =  extendSchema(PersonSchema, {
    mail : {
      type : String ,
      require : true
  },
  speciality : {
      type : String ,
      require : true 
  } , 
  avatar : {
    type : String 
  }
  } ,{timestamps : true});
   /*+++++++++++++++++++++++++++++++++++ Patient Schema Child +++++++++++++++++++++++++++++++++++++++*/
  const PatientSchema = extendSchema(PersonSchema , {
    avatar : {
        type : String 
      }
  } , {timestamps : true}) ;
    /*+++++++++++++++++++++++++++++++++++ Admin Schema Child +++++++++++++++++++++++++++++++++++++++*/
    const AdminSchema = extendSchema(PersonSchema , {
        mail : {
            type : String ,
            require : true
        },
        avatar : {
            name: { type: String, required: true , default : 'ceceeecc'  },
            url: { type: String, required: true , default : 'ceceeecc' },
          }
      } , {timestamps : true}) ;

  const Person = mongoose.model('Person',PersonSchema)
  const Doctor = mongoose.model('Doctor',DoctorSchema)
  const Patient = mongoose.model('Patient' , PatientSchema)
  const Admin = mongoose.model('Admin' , AdminSchema)


  module.exports = { Doctor , Patient , Admin} ;