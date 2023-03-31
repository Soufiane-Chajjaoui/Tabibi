
 const fs = require('fs');
 const path = require('path') 
const Reponse = require('../models/Reponse');
const { Admin } = require('../models/Person_Model')
 const {Urgance , Sous_urgance} = require('../models/Urgance');

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
                res.json({response : false})
            }
             else if(admin != null){
                
                //  res.json({response : true}) ;

                res.redirect('/admin/dashboard') ;
               }
        
           }
        })
}
 const addUrgance = (req ,res) =>{
    const namefile = Date.now()  + '.' + req.body.extension ;

    const urgance =new Urgance({libell :  req.body.libell});

    if(req.body.data_Image == 'vide'){
        urgance.name_Image = "imageBydefault" ;
       } else
       {
        urgance.name_Image = namefile ;
        const readfile = Buffer.from(req.body.data_Image , 'base64') ;
         
        fs.writeFileSync('./uploads/Urgance/'+namefile,readfile);
       }
       urgance.save().then( result =>  {res.json({response : 'urgance has been added'})  
       console.log('urgance has been added')}
       ).catch(err => console.log(err) )
    }
  
 const   add_Sous_urgance =  (req ,res) =>{
    const namefile = Date.now()  + '.' + req.body.extension ;

    const sous_urgance =new Sous_urgance({libell :  req.body.libell , 
        id_urgance : req.body.id_urgance ,
         id_reponse : req.body.id_reponse});

    if(req.body.data_Image == 'vide'){
        sous_urgance.name_Image = "imageBydefault" ;
       } else
       {
        sous_urgance.name_Image = namefile ;
        const readfile = Buffer.from(req.body.data_Image , 'base64') ;
         
        fs.writeFileSync('./uploads/Urgance/Sous_urgance/'+namefile,readfile);
       }
       sous_urgance.save().then( result =>  {res.json({response : 'sous urgance has been added'})  
       console.log('sous urgance has been added')}
       ).catch(err => console.log(err) )
    }
    const add_reponse =    (req , res ) =>{

        const namefile = Date.now()  + '.' + req.body.extension ;
        const rep =new Reponse({ 
            description :  req.body.discription
            });
            if(req.body.data_Image == 'vide'){
                rep.name_Image = "imageBydefault" ;
               } else
               {
                rep.name_Image = namefile ;
                const readfile = Buffer.from(req.body.data_Image , 'base64') ;
                 
                fs.writeFileSync('./uploads/Urgance/Reponse/'+namefile,readfile);
               }
               rep.save().then( result =>  {res.json({response : 'Reponse has been added'})  
               console.log('Reponse has been added')}
               ).catch(err => console.log(err) )

    }

    const get_urgance = async (req , res) => {
            // new version

      //    const urgances = [] ;
      // await  Urgance.find().then(result => { info_urgance = result  }).catch(err => {console.log(err) ; res.status(400).json({ response : err}) }) ;
      // const folderPath = './uploads/Urgance/'; // Replace with the path to your folder
      // const fileName = '1679611562364.jpg'; // Replace with the name of the file you're looking for
      
      // fs.readdir(folderPath, (err, files) => {
      //   if (err) throw err;
      
      //   files.forEach(file => {
      //     if (file === fileName) {
      //       const filePath = path.join(folderPath, file);
      
      //       fs.readFile(filePath , (err, data) => {
      //         if (err) throw err;
      
      //         console.log(data.toString('base64'));
      //       });
      //     }
      //   });
      // });
       
      // Last version
      
    //     const dirPath = path.join(__dirname, '../uploads/Urgance');
    //  fs.readdir(dirPath, (err, files) => {
    //   if (err) {
    //     return res.status(500).send('Error reading directory');
    //   }
    //   const imageFiles = files.filter(file => file.endsWith('.png') || file.endsWith('.jpg')  || file.endsWith('.gif')  || file.endsWith('.jpeg'));
    //   const imagePromises = imageFiles.map(file => new Promise((resolve, reject) => {
    //     fs.readFile(path.join(dirPath, file), (err, data) => {
    //       if (err) {
    //         reject(err);
    //       } else {
    //         resolve({ filename: file, data: data.toString('base64') });
    //       }
    //     });
    //   }));
    //   Promise.all(imagePromises).then(  async images => {
    //     const urgances = [] ;
    //     // Urgance.find().then(result => res.status(200).json({ response : result , length : images.length})).catch(err => {console.log(err) ; res.status(400).json({ response : err}) }) ;
    //   await  Urgance.find().then(result => { info_urgance = result  }).catch(err => {console.log(err) ; res.status(400).json({ response : err}) }) ;
    //    for (let i = 0; i < info_urgance.length; i++) {
    //             const obj  = new Object({
    //            info :   info_urgance[i] , Image : images[i].data} , 
    //        );
    //         urgances.push(obj);        
    //       }
    //        res.status(200).json({urgances})
    //    }).catch(error => {
    //     res.status(500).send("Error reading files " + error );
    //   });
    // });
    }
  

module.exports = {addUrgance , add_Sous_urgance , add_reponse , get_urgance , register_admin , login_admin}