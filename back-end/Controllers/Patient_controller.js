const { Patient } = require('../models/Person_Model') ;

const register_patient =  (req , res)=>  {

    
    const patient =new Patient(
        {
            complete_name:req.body.complete_name ,
            password : req.body.password ,
            CNI : req.body.CNI ,
            num_tele : req.body.num_tele ,
           
        }
       )
     patient.save().then( result =>  {res.json({response : 'patient has been added'})  
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
                     res.json({'message' : true}) ;
                    }
               else { 
                 res.json({'message' : false}) ;
                }
            })
}

module.exports = { register_patient , login_patient}