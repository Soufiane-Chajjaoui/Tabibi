
const DoctorController = require('../Controllers/Doctor_controller');
const PatientController = require('../Controllers/Patient_controller');
const AdminController = require('../Controllers/Admin_controller');

const fs = require('fs')
const path = require('path');
const express = require('express');
const upload = require('../middleware/upload');

const router = express.Router() ;
/* TEST MULTER is failure*/

router.get('upload_image' ,PatientController.register_patient) ;

/*      Router Admin       */
  router.post('/admin/add_Urgance' , AdminController.addUrgance) ;
  router.post('/admin/add_Sous_Urgance' , AdminController.add_Sous_urgance) ;
  router.post('/admin/add_Reponse' , AdminController.add_reponse) ;
  router.get('/admin/get_urgance' , AdminController.get_urgance) 


/*      Router Doctor       */
router.post('/signup_doctor' , DoctorController.register_doctor) ;

/*      Router Patient       */
router.post('/signup_patient' , PatientController.register_patient) ;
router.post('/login_patient' , PatientController.login_patient) ;
router.get('/images' ,  (req, res) => {
    const dirPath = path.join(__dirname, '../uploads/Person');
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
      Promise.all(imagePromises).then(images => {
        res.json(images);
      }).catch(error => {
        res.status(500).send('Error reading files');
      });
    });
  }) ;

module.exports = router ;