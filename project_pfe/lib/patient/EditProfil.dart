// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/actions/Agent.dart';
// import 'package:project_pfe/Models/ChatUser.dart';
import 'package:project_pfe/actions/Doctor.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfil extends StatefulWidget {
  EditProfil({super.key, required this.type});
  String? type;
  //final ChatUser me;

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  File? image;
  Patient? patient;
  Doctor? _doctor;
  Agent? agent;
  String? imgProfil;
  var file;
  _opengallery() async {
    file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (file != null) {
      setState(() async {
        image = File(file.path);
        // await APIs.updatePictureUser(File(_image));
      });
    }
  }

  _opencamera() async {
    file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
    if (file != null) {
      setState(() {
        image = File(file.path);
        // _image = file.path;
        // APIs.updatePictureUser(File(_image));
      });
    }
  }

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerTele = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> infoDoctor() async {
    final _pref = await SharedPreferences.getInstance();
    if (widget.type == 'doctor') {
      _doctor = await Doctor.getProfil();
      setState(() {
        _controllerName.text = _doctor!.complete_name.toString();
        _controllerTele.text = _doctor!.tele.toString();
        _controllerEmail.text = _doctor!.mail.toString();
        imgProfil = _doctor?.image!['url'];
      });
    } else if (widget.type == 'patient') {
      patient = await Patient.getProfil(
          await _pref.getString("_id")); // Await the getProfil method
      if (patient != null) {
        setState(() {
          _controllerName.text = patient!.complete_name.toString();
          _controllerTele.text = patient!.tele.toString();
          imgProfil = patient!.image?['url'];
        });
      }
    } else {
      agent = await Agent.getProfil();
      if (agent != null) {
        setState(() {
          _controllerEmail.text = agent!.mail.toString();
          _controllerName.text = agent!.complete_name.toString();
          _controllerTele.text = agent!.tele.toString();
          imgProfil = agent!.image?['url'];
        });
      }
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controllerName.dispose();
  //   _controllerTele.dispose();
  // }

  @override
  void initState() {
    super.initState();
    infoDoctor();
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
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.black45,
                        context: context,
                        builder: (_) => image != null
                            ? Center(
                                child: LottieBuilder.network(
                                    "https://assets9.lottiefiles.com/packages/lf20_md7jx0xq.json"),
                              )
                            : Center(child: CircularProgressIndicator()));
                    Navigator.pop(context, true);

                    if (widget.type == 'doctor') {
                      await Doctor.editMyProfil(image, _controllerName.text,
                          _controllerTele.text, _controllerEmail.text);
                      Navigator.pop(context, true);
                    } else if (widget.type == 'patient') {
                      await Patient.EditMyProfil(
                          image, _controllerName.text, _controllerTele.text);
                      Navigator.pop(context, true);
                    } else {
                      await Agent.ModifyProfil(image, _controllerName.text,
                          _controllerTele.text, _controllerEmail.text);
                      Navigator.pop(context, true);
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
                                    imageUrl: "${imgProfil}",
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
                      controller: _controllerTele,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.call),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  widget.type != 'patient'
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail_outline_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9))),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
