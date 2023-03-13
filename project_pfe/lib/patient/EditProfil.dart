// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  File? image;

  final pickedimage =  ImagePicker();

  setimage() async {
    var _image = await pickedimage.getImage(source: ImageSource.camera);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99d8d7),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'save',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 12),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                                borderRadius: BorderRadius.circular(20),
                                radius: 60,
                                onTap: () {
                                  setimage();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300.0),
                                  child: image == null
                                      ? Image.asset(
                                          'images/pngwing.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          width: 100,
                                          height: 100,
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                )),
                            Positioned(
                                top: 50,
                                left: 60,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera,
                                      size: 30,
                                      color: Color.fromARGB(255, 64, 57, 98),
                                    ))),
                          ],
                        ),
                      ),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label'),
                      input('label')
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Padding input(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        initialValue: label,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.cyan.shade600)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
