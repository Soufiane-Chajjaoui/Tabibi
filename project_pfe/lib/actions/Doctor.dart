// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Person.dart';
import 'package:project_pfe/actions/UserChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Doctor extends Person {
  String? mail;
  String? spec;
  static List<String> speciality = [
    "L’allergologie ou l’immunologie",
    "L’anesthésiologie",
    "L’andrologie",
    "La cardiologie",
    "La chirurgie",
    "La chirurgie cardiaque",
    "La chirurgie esthétique",
    " plastique et reconstructive",
    "La chirurgie générale",
    "La chirurgie maxillo-faciale",
    "La chirurgie pédiatrique",
    "La chirurgie thoracique",
    "La chirurgie vasculaire",
    "La neurochirurgie",
    "La dermatologie",
    "L’endocrinologie",
    "La gastro-entérologie",
    "La gériatrie",
    "La gynécologie",
    "L’hématologie",
    "L’hépatologie",
    "L’infectiologie",
    "La médecine aiguë",
    "La médecine du travail",
    "La médecine générale",
    "La médecine interne",
    "La médecine nucléaire",
    "La médecine palliative",
    "La médecine physique",
    "La médecine préventive",
    "La néonatologie",
    "La néphrologie",
    "La neurologie",
    "L’odontologie",
    "L’oncologie",
    "L’obstétrique.",
    "L’ophtalmologie.",
    "L’orthopédie.",
    "L’Oto-rhino-laryngologie.",
    "La pédiatrie.",
    "La pneumologie.",
    "La psychiatrie.",
    "La radiologie.",
    "La radiothérapie.",
    "La rhumatologie",
    "L’urologie"
  ];

  Doctor(
      {super.id,
      required super.gender,
      required super.tele,
      required this.mail,
      required super.complete_name,
      required super.password,
      required this.spec,
      required super.image});

  static Future<dynamic> registre_doctor(
    String? tele,
    String? complete_name,
    String? password,
    String? gender,
    String? email,
    String? speciality,
  ) async {
    var url = Uri.parse("http://192.168.1.4:8080/API/signup_doctor");
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      // I use Firebase so I don't need it
      'complete_name': complete_name?.trim(),
      'num_tele': tele?.trim(),
      'gender': gender,
      'mail': email?.trim(),
      'speciality': speciality,
      'password': password?.trim(),
    });

    var response = jsonDecode(res.body);
    print(response);
    if (res.statusCode == 200) {
      final _pref = await SharedPreferences.getInstance();
      await _pref.clear();
      await _pref.setString('_id', response['user']['_id']);
      return response['success'];
    } else {
      Fluttertoast.showToast(
          msg: response['error'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 219, 101, 92),
          textColor: Colors.white,
          fontSize: 17.0);
    }
  }

  static Future<dynamic> login_doctor(
      String? tele, String? password, context) async {
    var url = Uri.parse("http://192.168.1.4:8080/API/login_doctor");
    var response = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'tele': tele,
      'password': password,
    });
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(decode['doctor']);
      final _pref = await SharedPreferences.getInstance();
      _pref.clear();
      await _pref.setString('_id', decode['doctor']['_id']);
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "${decode["error"]}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 219, 101, 92),
        textColor: Colors.white,
        fontSize: 17.0,
      );
    }
  }

  static getChatPatient() async {
    List<UserChat> usersChat = [];

    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString('_id');
    var url =
        Uri.parse('http://192.168.1.4:8080/API/getChatPatients/${id!.trim()}');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      usersChat =
          decoded.map<UserChat>((item) => UserChat.fromJson(item)).toList();
      print(usersChat);
      return usersChat;
    } else {
      return [];
    }
  }

  static Future<dynamic> getProfil() async {
    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString('_id');
    print(id);
    var url =
        Uri.parse("http://192.168.1.4:8080/API/getProfil-doctor/${id?.trim()}");

    var response = await http.get(url);
    print(response.body);
    var res = jsonDecode(response.body);
    print(res);
    return Doctor.fromJson(res);
  }

  static editMyProfil(
      File? Image, String fullName, String number, String email) async {
    var url = Uri.parse('http://192.168.1.4:8080/API/update-profil-doctor');

    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString('_id');

    try {
      var request = http.MultipartRequest(
        'POST',
        url,
      );

      if (Image != null && Image.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'imageProfil',
          Image.path,
        ));
      }

      request.fields['fullName'] = fullName.trim();
      request.fields['tele'] = number.trim();
      request.fields['email'] = email.trim();
      request.fields['id'] = id!;

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Vos donnees ete bien modifier',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 219, 101, 92),
          textColor: Colors.white,
          fontSize: 17.0,
        );
      } else {
        print('Image upload failed. Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        tele: json['num_tele'].toString(),
        mail: json['mail'].toString(),
        password: json['password'].toString(),
        complete_name: json['complete_name'].toString(),
        spec: json['speciality'].toString(),
        gender: json['gender'].toString(),
        image: json['avatar'] != null
            ? json['avatar'] as Map<String, dynamic>
            : null,
        id: json['_id'].toString(),
      );
}
