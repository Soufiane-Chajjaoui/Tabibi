
const DoctorController = require('../Controllers/Doctor_controller');
const PatientController = require('../Controllers/Patient_controller');
const AdminController = require('../Controllers/Admin_controller');
const Auth = require('../Controllers/Auth');
const fs = require('fs') ;
const path = require('path');
const express = require('express');
const upload = require('../middleware/upload');
const { cloudinary } = require('../Tools/Cloudinary')
const router = express.Router() ;
const Uploader = require('../Tools/multer')

/*      Router Admin       */
    /* links */

  router.get('/login' , (req ,res) => {
    const username = req.session.username;
    console.log(`Username: ${username}`);
    res.render('auth/login') ;
  }) ;

  router.get('/register' , (req ,res) => {
    req.session.username = 'John'; 
    res.render('auth/register') ;
  }) ;



  router.get('/admin/dashboard' , (req ,res) => {
    res.render('admin/dashboard') ;
  })

  router.get('/' , (req ,res) => {
    res.render('home') ;
  })
  

 
 
    /* end links */

  /*      Action Admin       */

  router.post('/admin/register' ,  AdminController.register_admin) ;
  router.post('/admin/login' ,  AdminController.login_admin) ;

  router.get('/admin-get_Patients' , AdminController.getAllPatients) ;

  // CRUD URGANCE
  router.post('/admin-add_Urgance' , Uploader.single('image') , AdminController.addUrgance);
  router.get('/admin-get_urgance' , AdminController.get_urgance) ;
  router.post('/admin-update_urgance' ,  Uploader.single('image_up') , AdminController.update_urgance) ;
  router.delete('/delete-Urgance' , AdminController.delete_urgance) ;

  // CRUD SOUSURGANCE
  router.post('/admin-add_Sous_Urgance' , Uploader.single('image') , AdminController.add_sous_Urgance);
  router.get('/admin-get_Sous_urgance' , AdminController.get_sous_urgance) ;
  router.delete('/delete-Sous_urgance' , AdminController.delete_sous_urgance)
  router.post('/add-reponse' , Uploader.single('image_reponse') ,  AdminController.add_reponse)

  /*     end Action Admin    */

/*     end Router Admin       */

           //  API
/*      Router Doctor       */ 
router.post('/signup_doctor' , DoctorController.register_doctor) ;
router.post('/login_doctor' , DoctorController.login_doctor) ;

/*      Router Patient       */
router.post('/signup_patient' , PatientController.register_patient) ;
router.post('/login_patient' , PatientController.login_patient) ;
router.get('/API/get_urgance' , AdminController.API_get_urgance) ;
router.get('/API/get_sous_urgance/:id' , AdminController.API_get_sous_urgance) ;
router.get('/API/get_reponse/:id' , AdminController.API_get_Reponse) ;
router.get('/API/get-Profil/:id' , PatientController.profilPage) ;
router.post('/API/demandDoctor' , AdminController.demandDoctor) ;


 router.get('/images' ,  (req, res) => {
  //   const dirPath = path.join(__dirname, '../uploads/Person');
  //    fs.readdir(dirPath, (err, files) => {
  //     if (err) {
  //       return res.status(500).send('Error reading directory');
  //     }
  //     const imageFiles = files.filter(file => file.endsWith('.png') || file.endsWith('.jpg')  || file.endsWith('.gif')  || file.endsWith('.jpeg'));
  //     const imagePromises = imageFiles.map(file => new Promise((resolve, reject) => {
  //       fs.readFile(path.join(dirPath, file), (err, data) => {
  //         if (err) {
  //           reject(err);
  //         } else {
  //           resolve({ filename: file, data: data.toString('base64') });
  //         }
  //       });
  //     }));
  //     Promise.all(imagePromises).then(images => {
  //       res.json(images);
  //     }).catch(error => {
  //       res.status(500).send('Error reading files');
  //     });
  //   });
   }) ;

module.exports = router ;