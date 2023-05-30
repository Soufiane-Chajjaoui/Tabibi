const { Agent , Doctor , Patient } = require('../models/Person_Model');
const {Demand} = require('../models/Demand');
const { cloudinary } = require('../Tools/Cloudinary');

const get_Profil =async (req , res )=> {
    console.log(req.params.id)
    await Agent.findById(req.params.id.trim()).then((agent)=> { 
      res.status(200).json(agent);
    }).catch((error)=> {
      console.log(error);
    })
}
const updateProfil = async (req ,res) => { 

    Agent.findById(req.body.id).then( async (result) =>   {
      result.complete_name = req.body.fullName ;
      result.mail = req.body.email ;
      result.num_tele = req.body.tele;
      if (req.file)  {
      const up =  await cloudinary.uploader.upload(req.file.path , {
          folder : 'uploads'
        }) ;
        result.avatar.url = up.url ;
        result.avatar.public_id = up.public_id ;
      }
      result.save().then((doctor)=> res.status(200).json(doctor)).catch((error)=> res.status(400).json(error));
    }).catch(err => console.log(err)) ;
}
const getDoctors = async (req , res) => {


  await Doctor.find().then((result)=> {
    res.status(200).json({success : true , Doctors : result})
  }).catch((err) => {
    res.status(500).json({error : err , success : false });
  });
}

const get_Demand = async(req, res) => {
 
  Demand.find({ accepted : false } , {idPatient : 1 , _id : 0}).distinct('idPatient' , (err , distinct)=> {
    if (err) {
        console.log(err)
    }else {
        Patient.aggregate().lookup(
    
            {
              from : 'demands' ,
              localField : '_id'  ,
              foreignField : 'idPatient' , 
              as : 'demandPatient' ,
               
            }
      )
      .project({ 'complete_name' : 1 , 'avatar' : 1 , 'demandPatient' :{ $arrayElemAt: ['$demandPatient', 0] } })
      .match({ '_id' : { $in : distinct }})
      .sort({  'demandPatient.createdAt'  : 'desc'}) 

    .exec((err , result)=> {
    if (err) {
      console.log(err)
    }else {
      res.status(200).json(result)
    } ;
    }) ;
        }
  })  
}

const get_Patient_chat = async (req , res) =>{
  Patient.aggregate().lookup({
    from : 'demands',
    localField : '_id',
    foreignField : 'idPatient',
    as : 'PatientChat'
  }).project({ 'complete_name' : 1 , 'avatar' : 1 , 'PatientChat' : 1}).match({ 'PatientChat.accepted' : true}).exec((err , result) =>{
    if (err) {
      console.log(err.message);
    }else res.status(200).json(result);
  })
}

 

const login_agent =async (req, res) => {
  console.log(req.body);
  try {
    const agent = await Agent.login(req.body.tele , req.body.password)
   res.status(200).json({success : true , Agent : agent })
  } catch (error) {
    res.status(400).json({error : error.message});
  }
}

const accept_demade = (req, res) => {
   Demand.findByIdAndUpdate(req.params.id , {accepted : true}).then((agent) => {
     Patient.findByIdAndUpdate(req.params.idPatient ,{ $push : {
      Mychats : req.params.idAgent
     }}).then((result)=> {
      res.status(200).json({success : true}) 

     }).catch((err)=>{
      console.log(err)
     })
  })
  .catch((error) => res.status(400).json({ error : "problem de connection"}))
  
}

const reject_demand = async (req, res) => {

    await Demand.deleteOne( { idPatient : req.params.id}).then(() => res.status(200).json({success : true}))
    .catch((err) => res.status(400).json({success : false , error : "problem de connection"}));

}


module.exports = {get_Demand ,updateProfil , getDoctors ,get_Patient_chat , get_Profil , login_agent , accept_demade,reject_demand}
