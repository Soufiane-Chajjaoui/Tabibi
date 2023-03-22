
 const fs = require('fs');
 const path = require('path') 
const Reponse = require('../models/Reponse');
 const {Urgance , Sous_urgance} = require('../models/Urgance');

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

    const get_urgance = (req , res) => {

        const dirPath = path.join(__dirname, '../uploads/Urgance');
     fs.readdir(dirPath, (err, files) => {
      if (err) {
        return res.status(500).send('Error reading directory');
      }
      const imageFiles = files.filter(file => file.endsWith('.png') || file.endsWith('.jpg')  || file.endsWith('.gif')  || file.endsWith('.jpeg'));
      const imagePromises = imageFiles.map(file => new Promise((resolve, reject) => {
        fs.readFile(path.join(dirPath, file), (err, data) => {
          if (err) {
            reject(err);
          } else {
            resolve({ filename: file, data: data.toString('base64') });
          }
        });
      }));
      Promise.all(imagePromises).then(  async images => {
        const urgances = [] ;
        // Urgance.find().then(result => res.status(200).json({ response : result , length : images.length})).catch(err => {console.log(err) ; res.status(400).json({ response : err}) }) ;
      await  Urgance.find().then(result => { info_urgance = result  }).catch(err => {console.log(err) ; res.status(400).json({ response : err}) }) ;
       for (let i = 0; i < info_urgance.length; i++) {
                const obj  = new Object({
               info :   info_urgance[i] , Image : images[i].data} , 
           );
            urgances.push(obj);        
          }
           res.status(200).json({urgances})
       }).catch(error => {
        res.status(500).send("Error reading files " + error );
      });
    });
    }
  

module.exports = {addUrgance , add_Sous_urgance , add_reponse , get_urgance}