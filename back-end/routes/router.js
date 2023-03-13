
const DoctorController = require('../Controllers/Doctor_controller');
const PatientController = require('../Controllers/Patient_controller');
const fs = require('fs')
const path = require('path');
const express = require('express');
const upload = require('../middleware/upload');

const router = express.Router() ;
/* TEST MULTER is failure*/

router.get('upload_image' ,PatientController.register_patient)


/*      Router Doctor       */
router.post('/signup_doctor' , DoctorController.register_doctor) ;

/*      Router Patient       */
router.post('/signup_patient' , PatientController.register_patient) ;
router.post('/login_patient' , PatientController.login_patient) ;
router.get('/images' ,  (req, res) => {
    const dirPath = path.join(__dirname, '../uploads/');
    console.log(dirPath)
    fs.readdir(dirPath, (err, files) => {
      if (err) {
        return res.status(500).send('Error reading directory');
      }
      const imageFiles = files.filter(file => file.endsWith('.png') || file.endsWith('.jpg'));
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