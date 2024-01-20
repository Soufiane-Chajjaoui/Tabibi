

const {Doctor,Agent, Patient } = require('../models/Person_Model') ;
const fs = require('fs');
const { Demand } = require('../models/Demand') ;
const { Urgance } = require('../models/Urgance')
const  Sous_urgance  = require('../models/SousUrgance') ;

const { default: mongoose } = require('mongoose');
const { sous_sous_urgance } = require('../models/SousSousUrgance');
const { cloudinary } = require('../Tools/Cloudinary');
const register_patient = async (req , res)=>  {

 
    const patient =new Patient(
        {
            complete_name:req.body.complete_name ,
            password : req.body.password ,
            gender : req.body.gender ,
            num_tele : req.body.num_tele ,
            avatar: {
              url: "https://res.cloudinary.com/dw2qfkws9/image/upload/v1685028137/1946429_tctfox.png",
              public_id: '' // Assuming you have the public_id for the avatar image
            }
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

    patient.save().then( result =>  {res.status(200).json({success : true , User : result})  
     console.log('patient has been added')}
     ).catch(err => {
      if (err.code === 11000 ) {
        res.status(400).json({success : false, message : "Votre est deja enregistre vous peuvez ustilise authre numero"});
      }
      
     } )

}


const login_patient = async(req , res)=>{ 


    try {
      const patient = await Patient.login(req.body.num_tele , req.body.password);
      if (patient) {
        console.log(patient);
        res.status(200).json({ User : patient , success : true }); 
      }
    } catch (error) {
      res.status(400).json({success : false, error : error.message})
    }

}

const updateProfil = async(req, res) => {
    console.log(req.body)
     try {
      const patient = await Patient.findById(req.body.id.trim());
     
      if (patient) {
            patient.complete_name = req.body.fullName.trim();
            patient.num_tele = req.body.tele.trim();
         if (req.file) {
 
          const response = await cloudinary.uploader.upload(req.file.path , {
            folder : 'uploads',
          })
          patient.avatar.public_id = response.public_id
          patient.avatar.url = response.url

         }
         patient.save().then((result) => {res.status(200).json({ success: true, message: 'Vos donnees ont été bien modifiées' });}) 
         .catch((error) => {
          console.log(error)
         })  
        
      } else {
        res.status(404).json({ success: false, message: 'Patient not found' });
      }
    } catch (error) {
      console.log(error);
      res.status(500).json({ success: false, message: 'Problème survenu sur le serveur' });
    }
    
}
  const profilPage = (req , res) => {
    console.log(req.params);
    Patient.findById( {_id : req.params.id.trim() }).then((result)=>res.status(200).json(result)) .catch((err)=> console.log(err))
  }



  const API_get_urgance =   (req , res) => {
 

    Urgance.find()
    .then((result) => {res.status(200).json(result)})
    .catch(err => console.log(err))

    }




    const demandDoctor = async (req, res) => {
      try {
        const demand = new Demand({
          idPatient: req.body.id_patient,
        });
        await demand.save();
        res.status(200).json({ success: true });
      } catch (err) {
         res.status(500).json({ success: false, error: err.message });
      }
    };
    
  


  const API_get_Reponse = async function(req, res) {
    console.log(req.params.id);
    const urg = await Urgance.findOne({ "Sous_urgance.sous_sous_urgance._id": req.params.id });
    urg.Sous_urgance.forEach((element) => {
      const sous = element.sous_sous_urgance;
      const rep = sous.find((sous_sous) => sous_sous._id.toString() === req.params.id.trim());
      if (rep) {
        const reponses = rep.Reponse;
        res.json(reponses);
        return; // Exit the loop and prevent further code execution
      }
    });
  }
  


  const API_get_sous_sous_urgance =async (req, res) => {
        console.log(req.params.id)
 
        try {
        const urg = await Urgance.findOne({"Sous_urgance._id" : req.params.id});

       urg.Sous_urgance.forEach(element => {

           if(element._id.toString() === req.params.id){

          res.status(200).json(element.sous_sous_urgance);
          }
       });

        } catch (error) {
          console.log(error);
        }


 
  }

  const get_ChatUsers = async (req , res) =>{
    try {
      const patientId = req.params.id; // Get the patientId from the request parameters
  
      const patient = await Patient.findById(patientId); // Find the patient document by ID
  
      if (!patient) {
        return res.status(404).json({ error: 'Patient not found' });
      }
  
      const agentDoctorIds = patient.Mychats; // Get the array of Mychats (Agent and Doctor IDs)
  
      // Find the Agent and Doctor documents whose IDs exist in the Mychats array
      const agentsAndDoctors = await Promise.all([
        Agent.find({ _id: { $in: agentDoctorIds } }),
        Doctor.find({ _id: { $in: agentDoctorIds } })
      ]);
  
      const mergedArray = [].concat(...agentsAndDoctors); // Merge the arrays
      console.log(mergedArray);
      return res.status(200).json(mergedArray);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal Server Error' });
    }
    // try {
    //   const personId = req.params.id; // Get the personId from the request parameters
  
    //   // Find the Doctor and Agent documents where Mychats array contains the personId
    //   const agentsAndDoctors = await Promise.all([
    //     Doctor.find({ Mychats: personId }),
    //     Agent.find({ Mychats: personId })
    //   ]);
  
    //   const mergedArray = [].concat(...agentsAndDoctors); // Merge the arrays
  
    //   return res.status(200).json({ agentsAndDoctors: mergedArray });
    // } catch (error) {
    //   console.error(error);
    //   return res.status(500).json({ error: 'Internal Server Error' });
    // }
  }

const API_get_sous_urgance = async  (req ,res) =>  {


  // const result =   await   Sous_urgance.aggregate([{ $unwind :"$id_Urgance"}]).then(rs=> res.json(rs)).catch(err => console.log(err));

       await Urgance.findById(req.params.id ).distinct('Sous_urgance').then(result =>  {
          res.status(200).json(result);
         }
      ).catch(err => console.log(err)) ;

 }    




module.exports = { register_patient, updateProfil , get_ChatUsers ,  API_get_sous_sous_urgance ,API_get_urgance ,API_get_sous_urgance , API_get_Reponse , demandDoctor,profilPage , login_patient }