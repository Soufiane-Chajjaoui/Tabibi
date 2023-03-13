const { Patient } = require('../models/Person_Model') ;
const fs = require('fs');
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
       if(req.body.avatar == null){
        patient.avatar = "pngwing.png" ;
       }
       else { 
        patient.avatar = namefile ; 
        const readfile = Buffer.from(req.body.avatar , 'base64') ;
         
        fs.writeFileSync('./uploads/'+namefile,readfile);

           console.log(readfile);
      // const imgdata = req.body.avatar;

      // const base64Data = imgdata.replace(/^data:([A-Za-z-+/]+);base64,/, '');
      //  console.log(base64Data)
      // fs.writeFileSync('./uploads/' +namefile,base64Data)
    //   fs.writeFile(time + req.body.extension  , readfile);

    //     res.send("OK");
       }

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



module.exports = { register_patient , login_patient }