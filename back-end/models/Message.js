const { mongoose } = require('mongoose');


const SchemaMessage = mongoose.Schema({
    idSender : {
        type : mongoose.Schema.Types.ObjectId,
        require : true,
    },
    content : {
        type : String,
        require : true
    }, 
    idReceiver : {
        type : mongoose.Schema.Types.ObjectId,
        require : true
    }
    
} , {timestamps : true}

) 

const Message  = mongoose.model('Message' , SchemaMessage);

module.exports = Message;