
const DoctorController = require('../Controllers/Doctor_controller');
const PatientController = require('../Controllers/Patient_controller');
const AdminController = require('../Controllers/Admin_controller');
const AgentController = require('../Controllers/Agent_controller');
const ChatController = require('../Controllers/Chat_controller');
const Auth = require('../Controllers/Auth');
const fs = require('fs') ;
const path = require('path');
const express = require('express');
const upload = require('../middleware/upload');
const { cloudinary } = require('../Tools/Cloudinary')
const router = express.Router() ;
const Uploader = require('../Tools/multer')
const { AuthCurrent } = require('../middleware/Auth');

/*      Router Admin       */
    /* links */

  router.get('/login' , (req ,res) => {
    // const username = req.session.username;
    // console.log(`Username: ${username}`);
     res.render('auth/login') ;
  }) ;

  router.get('/register' , (req ,res) => {
    // req.session.username = 'John'; 
    res.render('auth/register') ;
  }) ;



  router.get('/admin/dashboard' , (req ,res) => {
    res.render('admin/dashboard') ;
  })

  router.get('/' , (req ,res) => {
    res.render('home') ;
  })
  

 
 
    /* end links */
    router.get("*" , AuthCurrent ); 

//////////////////////// Routes Admin /////////////////////////////////

  router.post('/admin/register' ,  AdminController.register_admin) ;
  router.post('/admin/login' ,  AdminController.login_admin) ;
  router.get('/admin-get_Patients' , AdminController.getAllPatients) ;
  router.get('/admin-get_Doctors' , AdminController.get_AllDoctors) ;

///////////////////////// Agent Controller ///////////////////////////////
  router.get('/admin-get_Agent' , AdminController.get_Agent) ;
  router.post('/admin-create_Agent' , AdminController.CreateAgent);

        // CRUD URGANCE
  router.post('/admin-add_Urgance' , Uploader.single('image') , AdminController.addUrgance);
  router.get('/admin-get_urgance' , AdminController.get_urgance) ;
  router.post('/admin-update_urgance' ,  Uploader.single('image_up') , AdminController.update_urgance) ;
  router.delete('/delete-urgance/:id/:public_id' , AdminController.delete_urgance) ;
  
  
      // GESTION NOTIFICATIONS
  router.get('/API/get-notifications' , AdminController.get_notification) 
  router.get('/API/count-notifications' , AdminController.count_notifications) 

  // CRUD SOUSURGANCE
  router.post('/admin-add_Sous_Urgance' , Uploader.single('image') , AdminController.add_sous_Urgance);
  router.get('/admin-get_Sous_urgance' , AdminController.get_sous_urgance) ;
  router.delete('/delete-sous-urgance/:id/:public_id' , AdminController.delete_sous_urgance);
  router.post('/update-sous-urgance' , Uploader.single('image_up'), AdminController.update_sous_urgance );
  
  // CRUD SOUS SOUS URGANCE   

  router.post('/add-sous-sous-urgance', Uploader.single('image_sous_sous')  , AdminController.add_sous_sous_urgance)
  router.get('/get-sous-sous-urgance', AdminController.get_sous_sous_urgance);
  router.post('/update-sous-sous-urgance', Uploader.single('image_up'), AdminController.update_sous_sous_urgance);
  router.delete('/delete-sous-sous-urgance', AdminController.delete_sous_sous_urgance) ;

     // CRUD REPONSE   
 
  router.get('/get-reponses', AdminController.get_reponse);
  router.post('/add-reponse' , Uploader.single('image_reponse') ,  AdminController.add_reponse);
  router.post('/update-reponse' , Uploader.single('image_up') ,  AdminController.update_reponse);
  router.delete('/delete-reponse' , AdminController.remove_reponse);
  /*     end Action Admin    */

/////////////////////////////// end Router Admin /////////////////////////////


///////////////////////////////  API           ///////////////////////////////
///////////////////////////////Routes Doctor  ///////////////////////////////
router.post('/API/signup_doctor' , DoctorController.register_doctor) ;
router.post('/API/login_doctor' , DoctorController.login_doctor) ;
router.get('/API/getProfil-doctor/:id' , DoctorController.getProfil) ;
router.post('/API/update-profil-doctor', Uploader.single('imageProfil') , DoctorController.EditMyProfil) ;
router.get('/API/getChatPatients/:id' , DoctorController.getPtientschat) ;

////////////////////////////// Routes Patient ////////////////////////////////       
router.post('/API/signup_patient' , PatientController.register_patient) ;
router.post('/API/login_patient' , PatientController.login_patient) ;
router.get('/API/get_urgance' , PatientController.API_get_urgance) ;
router.get('/API/get_sous_urgance/:id' , PatientController.API_get_sous_urgance) ;
router.get('/API/get_sous_sous_urgance/:id' , PatientController.API_get_sous_sous_urgance) ;
router.post('/API/update-Profil', Uploader.single('imageProfil') , PatientController.updateProfil);
router.get('/API/get_reponse/:id' , PatientController.API_get_Reponse) ;
router.get('/API/get-Profil/:id' , PatientController.profilPage) ;
router.post('/API/demandDoctor' , PatientController.demandDoctor) ;
router.get('/API/getUsersChat/:id' , PatientController.get_ChatUsers) ;

//////////////////////////////// Agent Routes //////////////////////////////////

router.post('/API/loginAgent' , AgentController.login_agent) ;
router.get('/API/notifications' , AgentController.get_Demand);
router.put('/API/AccepteDemand/:id/:idAgent/:idPatient', AgentController.accept_demade)
router.delete('/API/remove-demand/:id' , AgentController.reject_demand)
router.get('/API/get-Patients-chat', AgentController.get_Patient_chat);
router.get('/API/getDoctors' , AgentController.getDoctors);
router.get('/API/getProfil-Agent/:id' , AgentController.get_Profil);
router.post('/API/update-profil-agent' , Uploader.single('imageProfil') , AgentController.updateProfil);
router.get('/API/ShareWithDoctor/:idDoctor/:idPatient' , AgentController.ShareDoctorWithPatient);
//////////////////////////////// Chat routes ///////////////////////////////////

router.post('/API/storeMessage' ,ChatController.StoreMessage)

 router.get('/images'  ,  (req, res) => {
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