
const path  = require('path') ;
const multer = require('multer') ;



var storate = multer.diskStorage({
    destination : (req , file , cb) => cb(null , 'uploads/')  ,
    filename : (req , file ,cb) => { 
        let ext = path.extname(file.originalname) ;
        cb(null , Date.now() + ext)
     } ,

} ,
)

var upload = multer({
    storage : storage ,
    fileFilter :
})
