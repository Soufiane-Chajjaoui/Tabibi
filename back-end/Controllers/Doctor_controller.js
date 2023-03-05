

const { Doctor } = require('../models/Person_Model') ;

const register_doctor = (req , res) => {

    Doctor.findOne({
        mail : req.body.mail  }, (err , doctor) => {
            if(err) {
                console.log(err)
                res.json(err)
            } else {
                if(doctor == null){
                    const doctor =new Doctor(
                        {
                           _id : req.body._id ,
                           complete_name:req.body.complete_name ,
                             mail : req.body.mail ,
                             password : req.body.password ,
                             CNI : req.body.CNI ,
                             num_tele : req.body.num_tele ,
                           
                        }
                       )
                     doctor.save().then((result) => {res.json({response : 'doctor has been added'})  ;
                     console.log('doctor has been added')}
                     )
                }else {
                     console.log('this email is not available') ;
                     res.json({
                        message : "this email is not available"
                     }) ;
                     
                }
            }
        }
   )
}

 
   

module.exports = {register_doctor }