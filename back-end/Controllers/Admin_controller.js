
const path = require('path') 
const { Admin, Patient } = require('../models/Person_Model')
const {Urgance } = require('../models/Urgance');
const {Reponse } = require('../models/Reponse');
const { cloudinary } = require('../Tools/Cloudinary')
const Sous_urgance =  require('../models/SousUrgance') ;
const { exit } = require('process');
const Demand = require('../models/Demand') ;

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
    const API_get_urgance =   (req , res) => {
 

        Urgance.find()
        .then((result) => {res.status(200).json(result)})
        .catch(err => console.log(err))

        }

        
    const API_get_sous_urgance = async  (req ,res) =>  {


     // const result =   await   Sous_urgance.aggregate([{ $unwind :"$id_Urgance"}]).then(rs=> res.json(rs)).catch(err => console.log(err));
        
          await Sous_urgance.find({} , {reponse :0}).then(rs =>  {
             
             var list_sous = [] ;
            
            for (let index = 0; index < rs.length; index++) {            
             if (rs[index].id_Urgance.id_urg == req.params.id) {
                  list_sous.push(rs[index])
             } 
             }
             res.status(200).json(list_sous);

           }
        )
           .catch(err => console.log(err)) ;
        //await Sous_urgance.count().then(rs=> console.log(rs)).catch(err => console.log(err))
       
    }    

    const API_get_Reponse = async function(req , res) {

          await Sous_urgance.findById(req.params.id , { reponse : 1 }).then(result => res.status(200).json(result.reponse)).catch(err => console.log(err))
 
    }

    const demandDoctor = async (req ,res)=>{
        
      console.log(req.body);
        const demand = new Demand( {
            idPatient : req.body.id_patient ,
            Urgance_name : req.body.Urgance_name
        } )
        await demand.save();
    }
 
     

module.exports = {addUrgance , demandDoctor ,getAllPatients  ,API_get_Reponse, API_get_sous_urgance , add_sous_Urgance , API_get_urgance,  add_reponse , get_urgance , delete_sous_urgance , get_sous_urgance , register_admin , login_admin , delete_urgance , update_urgance}