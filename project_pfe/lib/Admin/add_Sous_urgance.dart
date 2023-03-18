// ignore_for_file: unnecessary_question_mark, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_pfe/actions/Sous_urgance.dart';
import 'package:project_pfe/actions/Urgance.dart';
import 'package:project_pfe/auth/validations.dart';

class Widget_Sous_ugance extends StatefulWidget {
  const Widget_Sous_ugance({super.key});

  @override
  State<Widget_Sous_ugance> createState() => _Widget_Sous_uganceState();
}

class _Widget_Sous_uganceState extends State<Widget_Sous_ugance> {
  final _formkey = GlobalKey<FormState>();

  var controller_Libell = TextEditingController();
  late Map<String, dynamic> filename =  {'base64': "vide", 'extension': "vide" };
  var file;
  File? imagefile;
  void _opengallery() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
      });
      await UploadImage();
    }
  }

  void _opencamera() async {
    file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
      });
      await UploadImage();
    }
  }

  Future UploadImage() async {
    if (imagefile == null) {
   
      return;
    }
    Uint8List fileBYtes = await imagefile!.readAsBytesSync();
    String baseFile = base64.encode(fileBYtes);
    print('*******************' + baseFile + '*********************');
    String extension = file.path.split('.').last;
    filename
        .addAll({'base64': baseFile, 'extension': file.path.split('.').last});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD Urgance'),
      ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(20),
                radius: 60,
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height / 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _opencamera();
                                      },
                                      icon: Icon(Icons.camera_alt_rounded)),
                                  Text('Camera')
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _opengallery();
                                      },
                                      icon: Icon(Icons.photo_album_rounded)),
                                  Text('gallery')
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: file == null
                      ? Image.asset(
                          'images/pngwing.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          width: 100,
                          height: 100,
                          File(imagefile!.path),
                          fit: BoxFit.cover,
                        ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) return 'Please entre Libell ';
                  return null;
                },
                controller: controller_Libell,
                cursorHeight: 30,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.cyan.shade600)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.brown)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(Icons.password_outlined),
                    prefixIconColor: Color(0xFF034277),
                    contentPadding: EdgeInsets.all(10),
                    label: Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.cyan.shade600,
                          fontFamily: 'PoppinsExtraLight',
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3279B6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                // background (button) color
                // foreground (text) color
              ),
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  Sous_urgance S_urgance = Sous_urgance(
                      libell: controller_Libell.text,
                      data_Image:  filename['base64'] ,
                      ext:  filename['extension'] ,
                      id_reponse: 'id_reponse',
                      id_urgance: 'id_urgance');
                  await S_urgance.add_sous_urgance();
                }

                // Navigator.of(context).pushNamed
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
