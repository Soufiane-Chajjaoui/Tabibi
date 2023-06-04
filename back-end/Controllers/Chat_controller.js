const Message = require('../models/Message');



const StoreMessage = async (req ,res)=>{
      const message = new Message({
        idSender : req.body.idSender ,
        content : req.body.content ,
        idReceiver : req.body.idReceiver
    })
    message.save().then((result) => {
        res.status(200).json({success:true})
        console.log(true)
    }).catch((err) => { 
        console.log(err)
        res.status(500).json({success : false })
    })
}


module.exports = {StoreMessage}