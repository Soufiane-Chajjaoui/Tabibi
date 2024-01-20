const express = require('express');
const FirebaseRouter = express.Router();
const AdminController = require('../Controllers/Admin_controller');



// FirebaseRouter.get('/patients' , AdminController.get_Patients) ;

// FirebaseRouter.get('/doctors' , AdminController.get_Doctors) ;



module.exports = FirebaseRouter;