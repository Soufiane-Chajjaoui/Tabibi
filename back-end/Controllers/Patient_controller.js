

const { Patient } = require('../models/Person_Model') ;
const fs = require('fs');
const { Demand } = require('../models/Demand') ;
const { Urgance } = require('../models/Urgance')
const  Sous_urgance  = require('../models/SousUrgance') ;

const { default: mongoose } = require('mongoose');
const register_patient = async (req , res)=>  {

    const namefile = Date.now()  + '.' + req.body.extension ;

    const patient =new Patient(
        {
            complete_name:req.body.complete_name ,
            password : req.body.password ,
            CNI : req.body.CNI ,
            num_tele : req.body.num_tele ,
        }
       )
    //    if(req.body.avatar == 'vide'){
    //     patient.avatar = "1678653984379.jpg" ;
    //    }
    //    else { 
    //     patient.avatar = namefile ; 
    //     const readfile = Buffer.from(req.body.avatar , 'base64') ;
    //     fs.writeFileSync('./uploads/Person/patients/'+namefile,readfile);

          // console.log(readfile);
      // const imgdata = req.body.avatar;

      // const base64Data = imgdata.replace(/^data:([A-Za-z-+/]+);base64,/, '');
      //  console.log(base64Data)
      // fs.writeFileSync('./uploads/' +namefile,base64Data)
    //   fs.writeFile(time + req.body.extension  , readfile);

    //     res.send("OK");
      // }

    patient.save().then( result =>  {res.status(200).json({response : 'patient has been added'})  
     console.log('patient has been added')}
     ).catch(err => console.log(err) )

}


const login_patient = function(req , res){ 
     Patient.findOne({         
            num_tele : req.body.num_tele ,
            password : req.body.password ,
            } , (err , patient)=> {
               if(err)  { 
                console.log(err) ;
                res.json(err)
            }
               else if (patient != null){
                     res.json({'message' : true , 'patient' : patient}) ;
                    }
               else { 
                 res.json({'message' : false }) ;
                }
            })
}
  const profilPage = (req , res) => {

    Patient.findById( req.params.id ).then((result)=>res.status(200).json(result)) .catch((err)=> console.log(err))
  }



  const API_get_urgance =   (req , res) => {
 

    Urgance.find()
    .then((result) => {res.status(200).json(result)})
    .catch(err => console.log(err))

    }




  const demandDoctor = async (req ,res)=>{
        
    console.log(req.body);
      const demand = new Demand( {
          idPatient : new mongoose.Types.ObjectId(req.body.id_patient)  ,
          Urgance_name : req.body.Urgance_name
      } )
      await demand.save().then((result)=> res.json(result)).catch((err)=>console.log(err));
  }
  const API_get_Reponse = async function(req , res) {

    await Sous_urgance.findById(req.params.id , { reponse : 1 }).then(result => res.status(200).json(result.reponse)).catch(err => console.log(err))

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




module.exports = { register_patient ,API_get_urgance ,API_get_sous_urgance , API_get_Reponse , demandDoctor,profilPage , login_patient }