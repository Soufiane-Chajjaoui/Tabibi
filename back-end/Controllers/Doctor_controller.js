

const { cloudinary } = require('../Tools/Cloudinary');
const { Doctor } = require('../models/Person_Model') ;

const register_doctor = async (req , res) => {
        console.log(req.body) ;
      try {
        const doctor = new Doctor(
            {
                complete_name : req.body.complete_name,
                num_tele : req.body.num_tele ,
                password : req.body.password ,
                mail : req.body.mail ,
                speciality : req.body.speciality ,
                gender : req.body.gender 
            }
          ) ;
           await doctor.save().then((result) => res.status(200).json({success : true , user: result}))
            .catch((err) => {        
                if (err.code === 11000) {
                res.status(400).json({error : 'Votre numero est deja enregistre'});
                console.log(err.message);
            }});
      } catch (error) {
        if (error.code === 11000) {
            res.status(400).json({error : error.message});
        }
         console.log(error.message);
      }
    
}

 const getProfil =async (req, res) => {
    console.log(req.params.id);
   await Doctor.findById(req.params.id.trim()).then(result => res.status(200).json(result)).catch(err => console.log(err));
 }
const login_doctor = async (req , res)=>{

   try {
    const doctor = await Doctor.login(req.body.tele , req.body.password);
    if (doctor) {
      res.status(200).json({success : true , doctor: doctor});
    }
   } catch (error) {
     res.status(400).json({error : error.message});
   }
}

const EditMyProfil =async (req, res) => {
    console.log(req.body)
    await Doctor.findById(req.body.id).then(async result => {
      result.complete_name = req.body.fullName ;
      result.mail = req.body.email ;
      result.num_tele = req.body.tele;
      if (req.file) {
      const up =  await cloudinary.uploader.upload(req.file.path , {
          folder : 'uploads'
        }) ;
        result.avatar.url = up.url ;
        result.avatar.public_id = up.public_id ;
      }
      result.save().then((doctor)=> res.status(200).json(doctor)).catch((error)=> res.status(400).json(error));
    }).catch(err => console.log(err)) ;
}
 
   

module.exports = {register_doctor ,EditMyProfil ,getProfil , login_doctor }