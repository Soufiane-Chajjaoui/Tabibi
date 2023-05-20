 const { default: mongoose } = require('mongoose');
 const extendSchema = require('mongoose-extend-schema');
 const bcrypt = require('bcrypt');
   /*+++++++++++++++++++++++++++++++++++ Person Schema Model Parent +++++++++++++++++++++++++++++++++++++++*/

const PersonSchema = new mongoose.Schema({
    id : {
      type : Number ,
      require : true
  } ,
  CNI : {
      type : String ,
      require : true ,
    },
  complete_name : {
      type : String ,
      require : true
  },
  num_tele : {
      type : Number ,
      require : true ,
      length : 10
  },
  password : {
      type : String ,
      required: [true, 'Please enter a password'],
      minlength:[6  , ' must be at least'] ,
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
            unique : [true , 'Your Email is already in use'] ,
            require : [true , 'Email is required']
        },
        avatar : {
            name: { type: String, required: true , default : 'ceceeecc'  },
            url: { type: String, required: true , default : 'ceceeecc' },
          }
      } , {timestamps : true}) ;


      AdminSchema.pre('save', async function (next) {
        console.log(this.mail, this.password);
        const salt =  bcrypt.genSaltSync(10);
        this.password = await bcrypt.hash(this.password, salt);
        next();
      });
      

      AdminSchema.statics.login = async function(email  , password){
    
        console.log( email , password); // {email : 'soufian@gmail.com'}
       const userCheck = await this.findOne({mail : email});
               if (!userCheck) {
                   throw new Error('Admin not registered');
               }else {
                  const auth = await bcrypt.compare(password, userCheck.password) ;
                  console.log(auth , userCheck.mail)
                  if (!auth) {
                      throw new Error('Invalid password');
                  }else {
                      return userCheck ;
                  }
               }
           }
  const Person = mongoose.model('Person',PersonSchema)
  const Doctor = mongoose.model('Doctor',DoctorSchema)
  const Patient = mongoose.model('Patient' , PatientSchema)
  const Admin = mongoose.model('Admin' , AdminSchema)

  AdminSchema.pre('save' ,async (next) =>{
    console.log(this.mail , this.password );
    const salt = await bcrypt.salt();
    this.password = await bcrypt.hash(this.password, salt);
    next();
  }) ;

 

  module.exports = { Doctor , Patient , Admin} ;