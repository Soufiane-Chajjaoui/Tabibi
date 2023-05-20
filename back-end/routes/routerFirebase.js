const express = require('express');
const FirebaseRouter = express.Router();
const AdminController = require('../Controllers/Admin_controller');



FirebaseRouter.get('/patients' , AdminController.get_Patients) ;




module.exports = FirebaseRouter;