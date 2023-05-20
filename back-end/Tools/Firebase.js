
var admin = require("firebase-admin");
var serviceAccount = require("../Tools/keyServiceAccount.json");
 
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://pfe-project-database-default-rtdb.europe-west1.firebasedatabase.app"
});

var db = admin.firestore();

module.exports = {db}

