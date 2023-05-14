import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/ChatUser.dart';

class APIs {
  static late ChatUser me;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

// Get a reference to the Firebase Storage instance
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<bool> UserExist() async {
    return (await firestore
            .collection("Users")
            .doc(auth.currentUser?.uid)
            .get())
        .exists;
  }

  static User get authUser => auth.currentUser!;

  static EditProfil(Name, about) async {
    authUser.updateDisplayName(Name);
    await firestore
        .collection("Users")
        .doc(authUser.uid)
        .update({'name': Name, 'about': about});
  }

  static Future<void> getSelfInfo() async {
    final userID = authUser.uid;
    await firestore
        .collection("Users")
        .doc(authUser.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        me = await ChatUser.fromJson(value.data()!);
      } else {
        await CreateUser().then((value) => getSelfInfo());
      }
    });

    // DocumentSnapshot about = await user.docs.first;
    // final bio = await about.data() as Map<String, dynamic>;
    // return bio['about'];
  }

  static Future<void> CreateUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = ChatUser(
      id: authUser.uid,
      name: authUser.displayName.toString(),
      email: authUser.email.toString(),
      about: "Hey , I'm using chat Tabibi ",
      createdAt: time,
      lastActive: time,
      image: authUser.photoURL.toString(),
      isOnline: false,
      pushToken: '',
    );
    return await firestore
        .collection("Users")
        .doc(authUser.uid)
        .set(chatuser.toJson());
  }

  static Future<void> updatePictureUser(File file) async {
    final ext = file.path.split('.').last;
    print(ext);
    //upload file to Storage firebase
    final ref = storage.ref().child('profilePicture/${authUser.uid}.${ext}');

    // upload image
    await ref.putFile(file, SettableMetadata(contentType: 'image/${ext}')).then(
        (p0) => {print(' data is uploaded ${p0.bytesTransferred / 1024} kb')});

    // upload file to firestore mean url
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('Users')
        .doc(authUser.uid)
        .update({'image': me.image});
  }
}
