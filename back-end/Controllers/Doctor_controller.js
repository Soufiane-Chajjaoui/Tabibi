

const { Doctor } = require('../models/Person_Model') ;

const register_doctor = (req , res) => {
    const namefile = Date.now()  + '.' + req.body.extension ;

    Doctor.findOne({
        mail : req.body.mail  }, (err , doctor) => {
            if(err) {
                console.log(err)
                res.json(err)
            } else {
                if(doctor == null){
                    const doctor =new Doctor(
                        {
                            complete_name:req.body.complete_name ,
                             mail : req.body.mail ,
                             password : req.body.password ,
                             CNI : req.body.CNI ,
                             num_tele : req.body.num_tele ,
                             speciality : req.body.speciality
                           
                        }
                       )
                       if(req.body.avatar == 'vide'){
                        doctor.avatar = "1678653984379.jpg" ;
                       }
                       else { 
                        patient.avatar = namefile ; 
                        const readfile = Buffer.from(req.body.avatar , 'base64') ;
                         
                        fs.writeFileSync('./uploads/Person/doctors/'+namefile,readfile);
                
                    
                       }
                     doctor.save().then((result) => {res.json({'response' : true})  ;
                     console.log('doctor has been added')}
                     )
                }else {
                     console.log('this email is not available') ;
                     res.json({
                        response : false
                     }) ;
                     
                }
            }
        }
   )
}
const login_doctor = function(req , res){

    Doctor.findOne({         
            mail : req.body.email ,
            password : req.body.password ,
            } , (err , doctor)=> {
               if(err)  { 
                console.log(err) ;
                res.json(err)
            }
               else if (doctor != null){
                     res.json({'message' : true}) ;
                     }
               else { 
                 res.json({'message' : false}) ;
 
                }
            })
}


 
   

module.exports = {register_doctor , login_doctor }