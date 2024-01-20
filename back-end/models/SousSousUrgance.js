const mongoose = require('mongoose') ;
const { Schema_reponse } = require('./Reponse') ;


const Schema_Sous_Sous_Urgance = mongoose.Schema({
    libell : {
        type: String
    },
    image : {
        public_id : String ,
        url : String
    },
    Reponse : [Schema_reponse]
})


const sous_sous_urgance = mongoose.model('sous_sous_urgance' , Schema_Sous_Sous_Urgance) ;

module.exports = {sous_sous_urgance , Schema_Sous_Sous_Urgance}