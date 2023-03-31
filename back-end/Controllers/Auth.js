const cloudinary = require('cloudinary').v2;
const { Admin } = require('../models/Person_Model') ;
require('dotenv').config() ;



// const sign_up = (req , res) =>{
    
//     // if (!req.body || Object.keys(req.body).length === 0) {
//     //     // Request body is null or empty
//     //     const file = req.body.file;
//     //     if (file) {
//     //         res.send({file})
//     //     }
//     //     res.status(400).send('Request body cannot be empty.');
//     //   } else {
//         console.log(req.body.email );
//         cloudinary.config({
//             cloud_name: process.env.cloud_name,
//             api_key: process.env.api_key,
//             api_secret: process.env.api_secret
//           });
//             Admin.findOne({mail : req.body.email},async  (err , admin)=>{
//                 if (err) {
//                     console.log(err)
//                 } else {
//                     if (admin != null) return res.render( 'sign_up' , {message : 'user is found'}) ;
//                     else {
//                         const file = req.body.file;
//                         const namefile = Date.now()  + '.' + req.body.extension ;
//                     const  result =   await  cloudinary.uploader.upload(file, { folder: 'uploads_test' }, (err, result) => {
//                             if (err) {
//                               console.error(err);
//                               res.status(500).json({ error: 'Failed to upload file' });
//                             } else { 
//                               console.log(result);
//                               const admin = new Admin({
//                                 complete_name:req.body.complete_name ,
//                                 password     : req.body.password ,
//                                 CNI          : req.body.CNI ,
//                                 num_tele     : req.body.num_tele ,
//                                 mail         : req.body.email,
//                                 avatar       : { name : result.public_id , 
//                                                 url : result.secure_url}
//                             }) ;
//                             admin.save().then(result => res.json({message : 'thanks you are now has been add'})).catch(err => console.log(err))

//                               res.status(200).json({ url: result.secure_url });
//                             }
//                           });
                      
//                     }
//                 }
//             })
//         //   }
// }
const sign_up = (req , res) =>{

    console.log(req.body.complete_name) 
    Admin.findOne({mail : req.body.email},  (err , admin)=>{
                         if (err) {
                             console.log(err)
                         } else{
                            if (admin != null) return res.render( 'sign_up' , {message : 'user is found'}) ;
                             else {
                                const admin = new Admin({
                                     complete_name:req.body.complete_name ,
                                     password     : req.body.password ,
                                     CNI          : req.body.CNI ,
                                     num_tele     : req.body.num_tele ,
                                     mail         : req.body.email,
                                     avatar       : {name : 'hhhhhhhhh' ,
                                                     url  : 'ddddddd'   }
                                 }) ;
                                 admin.save().then(() =>{(result)=> res.json({message : 'thanks you are now has been add'})}).catch(err => console.log(err))
                                    
                             }
                       }
                    }
                
    )}
    
    

module.exports = { sign_up }




