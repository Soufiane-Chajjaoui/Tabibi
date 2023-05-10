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

  var file;
  File? imagefile;
  _opengallery() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
      });
    }
  }

  _opencamera() async {
    file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
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
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Container(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 170,
                                    width: 170,
                                    imageUrl: "${widget.me.image}")
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
                                MyBottomSheet(
                                  onAlbumPressed: _opengallery(),
                                  onCameraPressed: _opencamera(),
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
