
 const multer = require('multer') ;
 const path = require('path') ;



var storage_image = multer.diskStorage({destination : function(req , file , cb){
    cb(null , '../project_pfe/images/')
   } ,

    filename : function(req , file , cb){
       const ext = path.extname(file.originalname)
       cb(null , Date.now()+ext)
    }})
    var upload = multer({
        storage : storage_image ,
        fileFilter : function(req , file , callback){
            if(file.mimetype == "image/png" || file.mimetype == "image/jpg" || file.mimetype == "image/jpeg"){
                callback(null , true) ;
            }else {
                console.log('error of type picture please check image');
                callback(null , false)
            }
        },
        limits : {
            fileSize : 1024 * 1024 * 2
        }
    })

   

    module.exports = upload ;
