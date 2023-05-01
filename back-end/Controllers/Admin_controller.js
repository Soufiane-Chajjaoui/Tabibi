
const path = require('path') 
const { Admin, Patient } = require('../models/Person_Model')
const {Urgance } = require('../models/Urgance');
const {Reponse } = require('../models/Reponse');
const { cloudinary } = require('../Tools/Cloudinary')
const Sous_urgance =  require('../models/SousUrgance') ;
const { exit } = require('process');
const {Demand} = require('../models/Demand') ;
const { count } = require('console');
const { default: mongoose } = require('mongoose');

const register_admin = (req , res )=>{
    Admin.findOne({         
        mail : req.body.email ,
        password : req.body.password ,
        } , (err , admin)=> {
           if(err)  { 
            console.log(err) ;
            res.json(err)
        }
           else {
            if (admin == null) {
                const admin_create = new Admin({
                    complete_name: req.body.prenom + ' ' + req.body.nom   ,
                    password : req.body.password ,
                    mail : req.body.email ,
                    CNI : req.body.cni ,
                    num_tele : req.body.tele ,
                    gender : req.body.gender
                })
                 admin_create.save().then((result) => { res.render('auth/login')}).catch((err)=>{
                    
                    res.json({'test':err})
                 })  ;
                //  res.json({'message' : 'has been register' , 'data' : admin_create}) ;
                //  console.log({'message' : 'has been register'}) ;
     
            }
             else if(admin != null){
                res.json({'message' : 'deja existe please try again'}) ;
               }
        
           }
        })
}

const login_admin = (req , res )=>{
 
     Admin.findOne({         
        mail : req.body.email ,
        password : req.body.password ,
        } , (err , admin)=> {
           if(err)  { 
            console.log(err) ;
            //res.json(err)
        }
           else {
            if (admin == null) {
                // res.json({response : 'ddddd'});
                  res.redirect('/login') ;
            }
             else if(admin != null){
                
                //  res.json({response : true}) ;

                res.redirect('/admin/dashboard') ;
               }
        
           }
        })
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
        console.log('urgance has been added')}
       ).catch(err => console.log(err) )
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
        .then((result) => {res.status(200).render('admin/Urgance' ,  { Urgances : result})
                            res.json(result)})
        .catch(err => console.log(err))

        }
const delete_urgance = async (req , res) => {
    console.log(req.params.id)

            try { 
                const urg = await Urgance.findOne(req.params.id) ;
                var id = urg.name_Image.public_id ;
                await cloudinary.uploader.destroy(id);

                  await  Urgance.deleteOne(req.params.id);
              res.send({ success: true , message : urg.libell });
            } catch (error) {
                console.log(error);
            }
        } 
const   add_sous_Urgance =  async (req ,res) =>{
 
    const sous_urgance = new Sous_urgance({libell :  req.body.libell , 
        id_Urgance : { id_urg :  req.body.id_urgance , libell_urg : req.body.libell__Urgance} 
         });
   

   const result =  await cloudinary.uploader.upload( req.file.path , {
        folder : 'uploads'
    }) ;

    sous_urgance.name_Image = {
        public_id : result.public_id ,
        url : result.secure_url
    }
    sous_urgance.save()
    .then(result => res.send({message : "Sous urgance " + req.body.libell + " ete bien enregistre"}))
    .catch(err => console.log(err))
        }
 
const get_sous_urgance = (req,res) => {
        Sous_urgance.find().then(result => res.render('admin/sous_urgance' , { sous_urgance : result })).catch(err => console.log(err))
        }  
const delete_sous_urgance = async (req , res) => {
    
        console.log(req.params.urganceId)
        await Sous_urgance.find({_id : req.params.id}).then( async (result) => {
            console.log(result)
            // await cloudinary.uploader.destroy(id); 
            // await  Urgance.deleteOne(req.params.id);
            // res.send({ success: true , message : result.libell });
        }).catch ((error) => {
            console.log(error); 
    } )
  
        }               
    const add_reponse = async (req , res ) =>{

       
             const sous_urgance = await Sous_urgance.findOne({ _id : req.body.id_sous_urgance}) ; 

              const result = await cloudinary.uploader.upload( req.file.path , {
                folder : 'uploads' ,
                })
                const rep = new Reponse({ 
                    description :  req.body.Description ,
                    name_Image : {
                        public_id : result.public_id ,
                        url : result.secure_url
                    }
                    });

                sous_urgance.reponse.push(rep);

               sous_urgance.save().then( result =>  {
               res.json({response : 'Reponse has been added'})  
               console.log('Reponse has been added')
            }
               ).catch(err => console.log(err) )

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
     

module.exports = {addUrgance ,count_notifications  , get_notification, getAllPatients  ,  add_sous_Urgance ,   add_reponse , get_urgance , delete_sous_urgance , get_sous_urgance , register_admin , login_admin , delete_urgance , update_urgance}