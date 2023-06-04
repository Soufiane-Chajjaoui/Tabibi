const {Admin} = require('../models/Person_Model');
const jwt = require('jsonwebtoken');

const AuthCurrent =  ( req ,res , next ) => {

    const Tabibi = req.cookies.Tabibi ;
        if (Tabibi) {
            jwt.verify(Tabibi , 'secret key hash payload' , async (err , TabibiDecoded)=>{
            if (err) {
                res.locals.admin = null ;
                next();
            } else {
                 const admin = await Admin.findById(TabibiDecoded.id);
                res.locals.admin = admin ;
                next();
            }
          })
        } else {
            res.locals.admin = null ;
            next();
        }

}

const isLogin = (req , res , next) =>{

    const Tabibi = req.cookies.Tabibi ;

    if(Tabibi){
        jwt.verify(Tabibi , 'secret key hash payload' , (err , TabibiDecoded)=>{
            if (err) {
                res.redirect('/login');
                next();
            } else {
                next();
            }
        })
    }else res.redirect('/login');
}

module.exports = { AuthCurrent }