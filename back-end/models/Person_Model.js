 const { default: mongoose } = require('mongoose');
 const extendSchema = require('mongoose-extend-schema');
 const bcrypt = require('bcrypt');
    /*+++++++++++++++++++++++++++++++++++ Person Schema Model Parent +++++++++++++++++++++++++++++++++++++++*/

        const PersonSchema = new mongoose.Schema({
            id : {
                type : Number ,
                require : true
            } ,
            complete_name : {
                type : String ,
                require : true
            },
            num_tele : {
                type : Number ,
                require : true ,
                unique : [true , 'Your Number is already in used'] ,
                length : 10
            },
            password : {
                type : String ,
                required: [true, 'Please enter a password'],
                minlength:[6  , ' must be at least'] ,
            },
            Mychats : [{
                type : mongoose.Schema.Types.ObjectId 
            }],
            gender  : {
                type : String ,
                enum : ['Male' , 'Female']
            } ,
            isOnline : {
                type : String ,
                enum : ['Online' , 'Offline'],
                default : 'Offline'
            },
            lastTime :{
                type : Date ,
                default : Date(),

            }

            },{timestamps : true});

   /*+++++++++++++++++++++++++++++++++++ Doctor Schema Child +++++++++++++++++++++++++++++++++++++++*/
        const DoctorSchema =  extendSchema(PersonSchema, {
            status :{
                type : String ,
                enum : ['availabe', 'busy' , 'suspended' , 'horsServised'],
                default : 'horsServised'
            },
            mail : {
                type : String ,
                unique : [true , 'Your email is Already registered'],
                require : true
            },
            speciality : {
                type : String ,
                require : true 
            } , 
            avatar : {
                url : {
                    type : String ,
                    default : "https://res.cloudinary.com/dw2qfkws9/image/upload/v1685028137/1946429_tctfox.png"
                } ,
                public_id : String , 
            }
            }  ,   {timestamps : true});

  
        DoctorSchema.pre('save', async function (next) {
            console.log(this.num_tele, this.password);
            const salt =  bcrypt.genSaltSync(10);
            this.password = await bcrypt.hash(this.password, salt);
            next();
        });

        DoctorSchema.statics.login = async function(numero  , password){
            
            console.log( numero , password); // {email : 'soufian@gmail.com'}
        const userCheck = await this.findOne({num_tele : numero});
                if (!userCheck) {
                    throw new Error('Doctor not registered Yet');
                }else {
                    const auth = await bcrypt.compare(password, userCheck.password) ;
                    console.log(auth , userCheck.num_tele)
                    if (!auth) {
                        throw new Error('Invalid password');
                    }else {
                        return userCheck ;
                    }
                }
            }
     /*+++++++++++++++++++++++++++++++++++ Doctor Schema Child +++++++++++++++++++++++++++++++++++++++*/
        const AgentSchema =  extendSchema(PersonSchema, {
            mail : {
                type : String ,
                unique : [true , 'Your email is Already registered'],
                require : true
            },

            avatar : {
                url : {
                    type : String ,
                    default : "https://res.cloudinary.com/dw2qfkws9/image/upload/v1685028137/1946429_tctfox.png"
                } ,
                public_id : String , 
            }
            }  ,   {timestamps : true});

  
        AgentSchema.pre('save', async function (next) {
                console.log(this.num_tele, this.password);
                const salt =  bcrypt.genSaltSync(10);
                this.password = await bcrypt.hash(this.password, salt);
                next();
            });

        AgentSchema.statics.login = async function(numero  , password){
            
            console.log( numero , password); // {email : 'soufian@gmail.com'}
        const userCheck = await this.findOne({num_tele : numero});
                if (!userCheck) {
                    throw new Error('Doctor not registered Yet');
                }else {
                    const auth = await bcrypt.compare(password, userCheck.password) ;
                    console.log(auth , userCheck.num_tele)
                    if (!auth) {
                        throw new Error('Invalid password');
                    }else {
                        return userCheck ;
                    }
                }
            }
   /*+++++++++++++++++++++++++++++++++++ Patient Schema Child +++++++++++++++++++++++++++++++++++++++*/
   
        const PatientSchema = extendSchema(PersonSchema , {
            avatar : {
                url : {
                    type : String ,
                    default : "https://res.cloudinary.com/dw2qfkws9/image/upload/v1685028137/1946429_tctfox.png"
                } ,
                public_id : String ,
            }
        } , {timestamps : true}) ;

        PatientSchema.pre('save', async function (next) {
            console.log(this.num_tele, this.password);
            const salt =  bcrypt.genSaltSync(10);
            this.password = await bcrypt.hash(this.password, salt);
            next();
        });

        PatientSchema.statics.login = async function(numero  , password){
            
            console.log( numero , password); // {email : 'soufian@gmail.com'}
        const userCheck = await this.findOne({num_tele : numero});
                if (!userCheck) {
                    throw new Error('Patient not registered Yet');
                }else {
                    const auth = await bcrypt.compare(password, userCheck.password) ;
                    console.log(auth , userCheck.num_tele)
                    if (!auth) {
                        throw new Error('Invalid password');
                    }else {
                        return userCheck ;
                    }
                }
            }
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
  const Agent = mongoose.model('Agent',AgentSchema)
  const Patient = mongoose.model('Patient' , PatientSchema)
  const Admin = mongoose.model('Admin' , AdminSchema)



 

  module.exports = { Doctor , Patient , Admin , PatientSchema , Agent} ;