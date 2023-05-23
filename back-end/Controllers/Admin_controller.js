
const path = require('path') 
const { Admin, Patient } = require('../models/Person_Model') ;
const {Urgance } = require('../models/Urgance');
const {Reponse } = require('../models/Reponse');
const { cloudinary } = require('../Tools/Cloudinary')
const {Sous_urgance} =  require('../models/SousUrgance') ;
const { exit } = require('process');
const {Demand} = require('../models/Demand') ;
const { count } = require('console');
const {db} = require('../Tools/Firebase');
const jwt = require('jsonwebtoken');
const { sous_sous_urgance } = require('../models/SousSousUrgance');
const { json } = require('body-parser');

// const register_admin = (req , res )=>{
//     Admin.findOne({         
//         mail : req.body.email ,
//         password : req.body.password ,
//         } , (err , admin)=> {
//            if(err)  { 
//             console.log(err) ;
//             res.json(err)
//         }
//            else {
//             if (admin == null) {
//                 const admin_create = new Admin({
//                     complete_name: req.body.prenom + ' ' + req.body.nom   ,
//                     password : req.body.password ,
//                     mail : req.body.email ,
//                     CNI : req.body.cni ,
//                     num_tele : req.body.tele ,
//                     gender : req.body.gender
//                 })
//                  admin_create.save().then((result) => { res.render('auth/login')}).catch((err)=>{
                    
//                     res.json({'test':err})
//                  })  ;
//                 //  res.json({'message' : 'has been register' , 'data' : admin_create}) ;
//                 //  console.log({'message' : 'has been register'}) ;
     
//             }
//              else if(admin != null){
//                 res.json({'message' : 'deja existe please try again'}) ;
//                }
        
//            }
//         })
// }

// const login_admin = (req , res )=>{
 
//      Admin.findOne({         
//         mail : req.body.email ,
//         password : req.body.password ,
//         } , (err , admin)=> {
//            if(err)  { 
//             console.log(err) ;
//             //res.json(err)
//         }
//            else {
//             if (admin == null) {
//                 // res.json({response : 'ddddd'});
//                   res.redirect('/login') ;
//             }
//              else if(admin != null){
                
//                 //  res.json({response : true}) ;

//                 res.redirect('/admin/dashboard') ;
//                }
        
//            }
//         })
// }
// handle errors
const handleErrors = (err) => {
    console.log(err.message, err.code);
    let errors = { email: '', password: '' };
        // duplicate email error
        if (err.code === 11000) {
          errors.email = 'this email is already registered';
          
        }else if (err.message === 'Admin not registered') {
          errors.email = 'email not registered yet';
       }

  
      if (err.message === 'Invalid password') {
        errors.password = 'Invalid password';
     }
  

   
    
     // validation errors
    if (err.message.includes('Admin validation failed')) {
      // console.log(err);
      Object.values(err.errors).forEach(({ properties }) => {
        // console.log(val);
        // console.log(properties);
        errors[properties.path] = properties.message;
      });
    }
  
    return errors;
  }

  const maxAge =  60 * 60 * 24 ;
  const createTOkens = (id) =>{
      return jwt.sign({ id } , 'secret key hash payload' , {
        expiresIn : maxAge
      });
  }

const register_admin = (req , res)=>{
    console.log(req.body)
    const admin_create = new Admin({
                complete_name: req.body.prenom + ' ' + req.body.nom   ,
                password : req.body.password ,
                mail : req.body.email ,
                CNI : req.body.cni ,
                num_tele : req.body.tele ,
                gender : req.body.gender
                 });

               
                    admin_create.save().then((admin) =>{

                      const token = createTOkens(admin._id);

                      res.cookie('jwt', token , { httpOnly: true  , maxAge: maxAge * 1000});

                        res.status(200).json( {admin} );

                    }).catch((error) =>{
                        const err = handleErrors(error)
                        console.log(error.message);
                        res.status(401).json({err})
                    });
                  
                 
        //  Admin.create({
        //     complete_name: req.body.prenom + ' ' + req.body.nom   ,
        //     password : req.body.password ,
        //     mail : req.body.email ,
        //     CNI : req.body.cni ,
        //     num_tele : req.body.tele ,
        //     gender : req.body.gender
        //  });        
}

const login_admin = async (req , res)=>{
      console.log(req.body);
      try {

      const { email, password } = req.body;

      const admin = await Admin.login(email , password) ;
      
      const token = createTOkens(admin._id);

      res.cookie('jwt', token , { httpOnly: true  , maxAge: maxAge * 1000});

      res.status(201).json({admin});
        
    } catch (error) {
 
      const err = handleErrors(error);

      res.status(401).json({err});
      }

    }
 
 const addUrgance = async (req ,res) =>{
     const urgance =new Urgance({libell :  req.body.libell});

     try {
      const result =   await cloudinary.uploader.upload( req.file.path , {
       folder : 'uploads' ,
      } ) ;
      urgance.name_Image = {
        public_id : result.public_id ,
        url : result.secure_url
      } ;
      } catch (error) {
        console.log(error)
     }
       urgance.save().then( result => 
        {    
         res.redirect('/admin-get_urgance') ;
        console.log('urgance has been added')
      }
       ).catch(err => console.log(err))
    }
    const update_urgance = async (req ,res) =>{
 
         const urg = await Urgance.findOne({_id : req.body.id}) ;
         urg.libell =  req.body.libell_up ;
         if (req.file) {
           await cloudinary.uploader.destroy(urg.name_Image.public_id );
          const result = await cloudinary.uploader.upload( req.file.path , {
            folder : 'uploads'
          })
          urg.name_Image = {
            public_id : result.public_id ,
            url : result.secure_url
          }
        }
        urg.save().then(result => {console.log(nadiii + ' ' + result)}).catch(err => {
            console.log(err)
        })
            res.redirect('/admin-get_urgance') ;
            console.log('urgance has been added')
      }
       const get_urgance =   (req , res) => {
         Urgance.find()
        .then((result) => {
           res.status(200).render('admin/Urgance' ,  { Urgances : result})
                            })
        .catch(err => console.log(err))

        }
    const delete_urgance = async (req , res) => {

          const { id , public_id} = req.params ;
          try { 
          await cloudinary.uploader.destroy(public_id);

          await  Urgance.findByIdAndDelete(id);
          res.json({ success: true  });
          } catch (error) {
          console.log(error);
          }
        } 
    const   add_sous_Urgance =  async (req ,res) =>{

        const urgance = await Urgance.findById(req.body.id_urgance) ;
    
        const sous_urgance = new Sous_urgance({libell :  req.body.libell });
      

      const result =  await cloudinary.uploader.upload( req.file.path , {
            folder : 'uploads'
        }) ;

          sous_urgance.name_Image = {
              public_id : result.public_id ,
              url : result.secure_url
          }
          urgance.Sous_urgance.push(sous_urgance);
          urgance.save()
          .then(result => res.redirect('back'))
          .catch(err => console.log(err))
            }
    
    const get_sous_urgance = (req,res) => {
            Urgance.find().distinct('Sous_urgance').then(result => {
              //res.json(result)
              res.render('admin/sous_urgance' , { sous_urgance : result })
            }).catch(err => console.log(err))
            }
    const update_sous_urgance = async (req, res) => {
      const { id , public_id , libell_up } = req.body ;
      try {      
      const urg = await Urgance.findOne({"Sous_urgance._id" : id});
      console.log(urg);
      if (urg) {
       const sous = urg.Sous_urgance.find(item => item._id.toString() === id) ;
       if (req.file) {
          await cloudinary.uploader.destroy(public_id.trim())
          const result = await cloudinary.uploader.upload(req.file.path ,{
            folder : 'uploads'
          })
          sous.name_Image.public_id = result.public_id ;
          sous.name_Image.url = result.url ;
       }
       sous.libell = libell_up ;
       urg.save().then((result) => {
        res.redirect('back') ;
       }).catch((err) => {
        console.log(err) ;
       })
      }else throw new Error("Not Found Urgance") ;

      }catch(err){
          console.log(err) ;
      }

    }         
    const delete_sous_urgance = async (req , res) => {
        
            const { id , public_id} = req.params
            try {
            const urg = await Urgance.findOne({"Sous_urgance._id" : id})
            await cloudinary.uploader.destroy(public_id)
            await urg.updateOne({ $pull: { Sous_urgance: { _id: id } } }, (err) => {
              if (err) {
                console.error('An error occurred while deleting the Sous_urgance object:', err);
              } else {
                res.json({success : true});
                console.log('Sous_urgance object deleted successfully');
              }
            });
            } catch(err){

            }
            
  
        }               
    const add_sous_sous_urgance = async (req ,res )=>{
            console.log(req.body , req.file.path); 
            const urgance =  await  Urgance.findOne({"Sous_urgance._id" : req.body.id_sous_urgance}) ;
            const sous = urgance.Sous_urgance.find(item => item._id == req.body.id_sous_urgance);

            const result = await  cloudinary.uploader.upload(req.file.path , {folder : 'uploads'})
            sous.sous_sous_urgance.push( new sous_sous_urgance({
              libell : req.body.libell,
              image: {
                public_id : result.public_id ,
                url : result.secure_url
              }
            }))
            urgance.save().then( (done)=> {
              res.redirect('back')
            }).catch((err)=> {
              console.log("error")
              })
            console.log(urgance)
          // Urgance.find(
          //   {
          //     //_id : "6469463976ebff4f5a421e9e",
          //     "Sous_urgance._id" : "64698565a325a8d198d44c19"
          //   }, (err , urgance)=>{
          //     if (err) {
          //       console.error(err);
          //     }else {
          //     const arraysous =   urgance.Sous_urgance
          //        res.json(arraysous)
          //     }
          //   });

          // const urgance =  await  Urgance.findOne({"Sous_urgance._id" : "646984a72a17fc1442d42304"}) ;
          // const sous = urgance.Sous_urgance.find(item => item.libell == 'mmmmmm');
          // sous.sous_sous_urgance.push( new sous_sous_urgance({
          //   libell : "wa 3yett" ,
          //   image: {
          //     public_id : "ssssssssssssssssss",
          //     url : "uuuuuuuuuurrrrrrrrrrrllllllllllllllll"
          //   }
          // }))
          // urgance.save().then( (done)=> {
          //   console.log("done")
          // }).catch((err)=> {
          //   console.log("error")
          // })
    
    }
    const update_sous_sous_urgance = async (req ,res)=>{

        const { id, libell, public_id } = req.body;
        console.log(id);
        const urgance = await Urgance.findOne({ "Sous_urgance.sous_sous_urgance._id": id });
        let found = false;
      
        if (urgance) {
          for (const element of urgance.Sous_urgance) {
            const sous = element.sous_sous_urgance;
            const soussousIndex = sous.findIndex(item => item._id.toString() === id);
            
            if (soussousIndex !== -1) {
              const soussous = sous[soussousIndex];
      
              if (req.file) {
                await cloudinary.uploader.destroy(public_id.trim());
                const result = await cloudinary.uploader.upload(req.file.path, {
                  folder: 'uploads'
                });
      
                soussous.image.public_id = result.public_id;
                soussous.image.url = result.url;
              }
      
              soussous.libell = libell;
      
              try {
                await urgance.save();
                res.redirect('back');
              } catch (err) {
                console.log(err);
                res.status(500).json({ error: 'An error occurred while updating the sous_sous_urgance' });
              }
              
              found = true;
              break;
            }
          }
        }
      
        if (!found) {
          res.json('not found');
        }
      };

    const get_sous_sous_urgance = async(req ,res )=>{
        const sous_sous_urg = await Urgance.find().distinct('Sous_urgance.sous_sous_urgance').then((result)=> {
          res.render('admin/sous_sous_urgance' , { sous_sous_urgance : result});
        }).catch((error)=>{
          console.log(error);
        })
    }

    const delete_sous_sous_urgance = async (req, res) => {
      const { id , public_id } = req.body ;
          const urgance = await Urgance.findOne({ "Sous_urgance.sous_sous_urgance._id": id });
            let found = false;

            if (urgance) {
              urgance.Sous_urgance.forEach(async element => {
                const sous = element.sous_sous_urgance;
                const soussousIndex = sous.findIndex(item => item._id.toString() === id);
                if (soussousIndex !== -1) {
                  found = true;
                  // // get Reponse object to get her name_Image public_id
                  // const soussous = soussous.Reponse.at(soussousIndex) ;
                  // Remove file from Cloud Storage
                  await cloudinary.uploader.destroy(public_id) ;
                  // Remove the sous_sous_urgance object from the array
                  element.sous_sous_urgance.splice(soussousIndex, 1);

                  urgance.save().then(done => {
                    console.log(done);
                    res.json({ success : true , message: 'Sous Sous Urgance deleted successfully' });
                  }).catch(err => {
                    console.log(err);
                    res.status(500).json({ error: 'An error occurred' });
                  });
                }
              });
            }

            if (!found) {
              res.json('not found');
            }

    }
    const add_reponse = async (req , res ) =>{
      console.log(req.body)
      const urgance = await Urgance.findOne({"Sous_urgance.sous_sous_urgance._id": req.body.id_sous_sous_urgance});
      let found = false;
      
      if (urgance) {
        urgance.Sous_urgance.forEach(async element => {
          const sous = element.sous_sous_urgance;
          const soussous = sous.find(item => item._id.toString() === req.body.id_sous_sous_urgance);
          if (soussous) {
            found = true;
            const result = await  cloudinary.uploader.upload(req.file.path , {folder : 'uploads'})
            soussous.Reponse.push(new Reponse({
              description: req.body.Reponse,
              name_Image : {
                public_id : result.public_id ,
                url : result.url
              },
              moreDetails: {
                details: req.body.MoreDetails
              }
            }));
            
            urgance.save().then(done => {
              res.redirect('back');
            }).catch(err => {
              console.log(err);
              res.status(500).json({ error: 'An error occurred' });
            });
          }
        });
      }
      
      if (!found) {
        res.json('not found');
      }
      
      
          // const sous = urgance.map(item => )
          //  const sous = urgance.Sous_urgance.find(item => item._id == '646a64929fd57ac3ecde9fbe');
          //   console.log(sous)
          // // const sous_sous_urg = sous.sous_sous_urgance.find(item => item._id == '646a64929fd57ac3ecde9fbe');
          
          // // console.log(sous_sous_urg.Reponse)

          // const newReponse = new Reponse({
          //   description : 'hhhhhhhhhhhhh' ,
          //   moreDetails : {
          //       details : " sssppppppppsssssssssssssss"
          //   }
          // });

          // sous_sous_urg.Reponse.push(newReponse) ;

          // urgance.save().then((done) => {
            
          //   console.log(done) ;
          // }).catch((err) => {
          //  console.log(err) ;
          // });

            //  const sous_urgance = await Urgance.findOne({ _id : req.body.id_sous_urgance}) ; 

            //   const result = await cloudinary.uploader.upload( req.file.path , {
            //     folder : 'uploads' ,
            //     })
            //     const rep = new Reponse({ 
            //         description :  req.body.Description ,
            //         name_Image : {
            //             public_id : result.public_id ,
            //             url : result.secure_url
            //         }
            //         });

            //     sous_urgance.reponse.push(rep);

            //    sous_urgance.save().then( result =>  {
            //    res.json({response : 'Reponse has been added'})  
            //    console.log('Reponse has been added')
            // }
            //    ).catch(err => console.log(err) )

    }

    const get_reponse = async(req, res) => {
       await Urgance.find().distinct('Sous_urgance.sous_sous_urgance.Reponse').then((result)=> {
        res.render('admin/Reponse' , { reponses : result})
       }).catch((err) => {
          console.log(err)
      })
    }

    const update_reponse = async (req, res) => {
      console.log(req.body) ;
      const urgance = await Urgance.findOne({ "Sous_urgance.sous_sous_urgance.Reponse._id": req.body.id });
        let found = false; 

        if (urgance) {
          urgance.Sous_urgance.forEach( async element => {
            const sous = element.sous_sous_urgance;
            const soussous = sous.find(item => item.Reponse.some(reponse => reponse._id.toString() === req.body.id));
            if (soussous) {
              const reponse = soussous.Reponse.find(reponse => reponse._id.toString() === req.body.id);
              if (reponse) {
                found = true;
                // Update the information of the reponse object
                reponse.description = req.body.Reponse;
                reponse.moreDetails.details = req.body.MoreDetails;
                if (req.file) {
                  const publicId = reponse.name_Image.public_id ;
                  await cloudinary.uploader.destroy(publicId);
                  const result = await cloudinary.uploader.upload( req.file.path , {
                    folder : 'uploads',
                  })
                  reponse.name_Image.url = result.url;
                  reponse.name_Image.public_id = result.public_id
                }
                urgance.save().then(done => {
                  console.log(done);
                  res.redirect('back');
                }).catch(err => {
                  console.log(err);
                  res.status(500).json({ error: 'An error occurred' });
                });
              }
            }
          });
        }

        if (!found) {
          res.json('not found');
        }

      }

    const remove_reponse = async (req , res)=>{
      const {id , public_id} =req.body ;
      const urgance = await Urgance.findOne({ "Sous_urgance.sous_sous_urgance.Reponse._id": id });
      let found = false;

      if (urgance) {
        urgance.Sous_urgance.forEach(async element => {
          const sous = element.sous_sous_urgance;
          const soussous = sous.find(item => item.Reponse.some(reponse => reponse._id.toString() === id));
          if (soussous) {
            const reponseIndex = soussous.Reponse.findIndex(reponse => reponse._id.toString() === id);
            if (reponseIndex !== -1) {
              found = true;
              // get Reponse object to get her name_Image public_id
              const rep = soussous.Reponse.at(reponseIndex) ;
               // Remove file from Cloud Storage
               await cloudinary.uploader.destroy(rep.name_Image.public_id) ;
              // Remove the reponse from the array
              soussous.Reponse.splice(reponseIndex, 1);

              urgance.save().then(done => {
                console.log(done);
                res.status(201).json({ success : true , message: 'Reponse deleted successfully' });
              }).catch(err => {
                console.log(err);
                res.status(500).json({ error: 'An error occurred' });
              });
            }
          }
        });
      }

      if (!found) {
        res.json('not found');
      }


    }  

   


    const getAllPatients = async (req ,res) => {

       await Patient.find().then((all)=>{
                   res.status(200).render( 'admin/Patients',{Patients : all}) ;
                    }).catch((err)=> console.log(err))
            }


    //    API


        
 
 



const get_notification =async(req , res) =>{

 // dataArray =  result.map(({idPatient})=> new mongoose.Types.ObjectId(idPatient)) ;
                    
                          Demand.find({ accepted : false } , {idPatient : 1 , _id : 0}).distinct('idPatient' , (err , distinct)=> {
                            if (err) {
                                console.log(err)
                            }else {
                                Patient.aggregate().lookup(
                            
                                    {
                                      from : 'demands' ,
                                      localField : '_id'  ,
                                      foreignField : 'idPatient' , 
                                      as : 'urgancebyPatient' ,
                                       
                                    }
                              )
                              .project({ 'complete_name' : 1 , 'urgancebyPatient' :{ $arrayElemAt: ['$urgancebyPatient', 0] } })
                              .match({ '_id' : { $in : distinct }})
                              .sort({  'urgancebyPatient.createdAt'  : 'asc'}) 
                   
                           .exec((err , result)=> {
                      if (err) {
                          console.log(err)
                      }else {
                           res.status(200).json({data : result , success : true})
                      } ;
                  }) ;
                            }
                          })  
     } 
const count_notifications =   (req ,res )=> {

           Demand.distinct('idPatient' , {accepted : false} , (err , data)=>{
            if (err) {
                console.log(err)
            }else 
            res.status(200).json({count : data.length  , success : true})

         })
       }

 const get_Patients = (req, res) => {

      const collectionRef = db.collection('Users');
      collectionRef.where('role' , '==' , 'patient').get()
      .then((result )=>{
        var data = [] ;
        result.forEach(user => {
            const datauser = user.data() ;
            const itemUser = {
              id : user.id,
              ...datauser
            }
            console.log(datauser)
            data.push(itemUser)
        })
         
        res.render('admin/Patients' ,{Patients : data});
      }).catch((err) => {
      console.log(err)
      })


 }

 const get_Doctors = (req, res) => {

  const collectionRef = db.collection('Users');
  collectionRef.where('role' , '!=' , 'patient').get()
  .then((result )=>{
    var data = [] ;
    result.forEach(user => {
        const datauser = user.data() ;
        const itemUser = {
          id : user.id,
          ...datauser
        }
        console.log(datauser)
        data.push(itemUser)
    })
     
    res.render('admin/Doctors' ,{Patients : data});
  }).catch((err) => {
  console.log(err)
  })


}
     

module.exports = {addUrgance ,get_Patients , update_sous_sous_urgance ,delete_sous_sous_urgance ,remove_reponse , update_reponse , get_reponse, get_sous_sous_urgance, add_sous_sous_urgance , get_Doctors ,count_notifications  , get_notification, getAllPatients  ,  add_sous_Urgance ,   add_reponse , get_urgance , delete_sous_urgance , update_sous_urgance , get_sous_urgance , register_admin , login_admin , delete_urgance , update_urgance}