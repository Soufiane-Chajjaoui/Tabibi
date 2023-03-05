
const DoctorController = require('../Controllers/Doctor_controller');
const PatientController = require('../Controllers/Patient_controller');

const express = require('express')

const router = express.Router() ;

/*      Router Doctor       */
router.post('/signup_doctor' , DoctorController.register_doctor) ;

/*      Router Patient       */
router.post('/signup_patient' , PatientController.register_patient) ;
router.post('/login_patient' , PatientController.login_patient) ;

module.exports = router ;