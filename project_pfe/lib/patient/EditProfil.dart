// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/Models/ChatUser.dart';

import '../Agent/widgets/showbottomsheet.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key, required this.me});
  final ChatUser me;

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  File? image;
  late String _image;
  var file;
  _opengallery() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery , imageQuality: 80);
    if (file != null) {
      setState(() async {
        image = File(file.path);
        _image = file.path;
        await APIs.updatePictureUser(File(_image));
      });
    }
  }

  _opencamera() async {
    file = await ImagePicker().pickImage(source: ImageSource.camera , imageQuality: 80);
    if (file != null) {
      setState(() {
        image = File(file.path);
        _image = file.path;
        APIs.updatePictureUser(File(_image));
      });
    }
  }

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAbout = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _controllerName.text = "${widget.me.name}".toString();
      _controllerAbout.text = "${widget.me.about}".toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99d8d7),
      body: SafeArea(
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded)),
              TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      APIs.EditProfil(
                          _controllerName.text, _controllerAbout.text);
                      // APIs.getSelfInfo();
                    }
                  },
                  child: Text(
                    'save',
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBoldItalic', fontSize: 22),
                  ))
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                          borderRadius: BorderRadius.circular(70),
                          onTap: () {
                            // setimage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(85.0),
                            child: image == null
                                ? CachedNetworkImage(
                                    imageUrl: widget.me.image,
                                    fit: BoxFit.cover,
                                    height: 170,
                                    width: 170,
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'images/user.png',
                                      fit: BoxFit.cover,
                                      height: 170,
                                      width: 170,
                                    ),
                                  )
                                : Image.file(
                                    image!,
                                    height: 170,
                                    width: 170,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                // setimage();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (Context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: Colors.black87,
                                                foregroundColor:
                                                    Colors.white70),
                                            onPressed: () => _opencamera(),
                                            iconSize: 40,
                                            icon: const Icon(
                                                Icons.camera_enhance)),
                                        IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: Colors.black87,
                                                foregroundColor:
                                                    Colors.white70),
                                            onPressed: () => _opengallery(),
                                            iconSize: 40,
                                            icon: Icon(
                                                Icons.photo_album_rounded)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.blue,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      onSaved: (newValue) => APIs.me.name = newValue ?? '',
                      controller: _controllerName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      onSaved: (newValue) => APIs.me.about = newValue ?? '',
                      controller: _controllerAbout,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
