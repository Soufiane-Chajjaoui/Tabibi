const multer = require('multer');

module.exports = multer({
  storage: multer.diskStorage({}),
  limits: {   // Set the maximum file size (in bytes)
    fileSize: 10 * 1024 * 1024, // 10MB 
  }
});