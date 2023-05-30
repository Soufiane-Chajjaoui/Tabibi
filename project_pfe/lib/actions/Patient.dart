// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_declarations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Demand.dart';
import 'package:project_pfe/actions/Person.dart';
import 'package:project_pfe/actions/Reponse.dart';
import 'package:project_pfe/actions/SousSousUrgance.dart';
import 'package:project_pfe/actions/Sous_urgance.dart';
import 'package:project_pfe/actions/Urgance.dart';
 import 'package:shared_preferences/shared_preferences.dart';

class Patient extends Person {
  Patient(
      {super.id,
      required super.tele,
      required super.gender,
      required super.complete_name,
      required super.password,
      required super.image});

  static Future<dynamic> registre_patient(
    String? gender,
    String? tele,
    String? complete_name,
    String? password,
  ) async {
    var url = Uri.parse("http://192.168.1.3:8080/signup_patient")
        // .replace(host: "192.168.1.3")
        ;
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'complete_name': complete_name?.trim(),
      'gender': gender?.trim(),
      'num_tele': tele?.trim(),
      'password': password?.trim(),
    });
    var response = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final _prefs = await SharedPreferences.getInstance();
      await _prefs.clear();
      await _prefs.setString('_id', response["User"]["_id"]);
      return response;
    } else {
      Fluttertoast.showToast(
          msg: response['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 219, 101, 92),
          textColor: Colors.white,
          fontSize: 17.0);
    }
  }

  static getUrgance() async {
    List<Urgance> list = [];
    var url = Uri.parse('http://192.168.1.3:8080/API/get_urgance');

    var res = await http.get(url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      data.forEach((value) => {
            list.add(Urgance(
                libell: value['libell'],
                id: value['_id'],
                url: value['name_Image']['url']))
          });
      print(list);
      return list;
    }
    return [];
  }

  static get_sous_urgance(String id) async {
    List<Sous_urgance> list = [];

    var url = Uri.parse("http://192.168.1.3:8080/API/get_sous_urgance/${id}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      data.forEach((element) => {list.add(Sous_urgance.fromJson(element))});
      return list;
    } else {
      return [];
    }
  }

  static get_sous_sous_urgance(String id) async {
    List<SousSousUrganceobj> list = [];
    var url =
        Uri.parse("http://192.168.1.3:8080/API/get_sous_sous_urgance/${id}");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      data.forEach((element) => list.add(SousSousUrganceobj.fromJson(element)));
      return list;
    } else
      return [];
  }

  static get_reponse(String id) async {
    List<Reponse> list = [];
    var url = Uri.parse("http://192.168.1.3:8080/API/get_reponse/${id}");

    var rep = await http.get(url);

    if (rep.statusCode == 200) {
      var data = jsonDecode(rep.body);
      data.forEach((element) {
        list.add(Reponse.fromJson(element));
      });
      list.add(Reponse(description: '', url: ''));
      return list;
    } else
      return [];
  }

  static Future<dynamic> login_patient(
      String? tele, String? password, context) async {
    var url = Uri.parse("http://192.168.1.3:8080/API/login_patient")
        // .replace(host: "192.168.1.3")
        ;
    var response = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'num_tele': tele,
      'password': password,
    });
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final _pref = await SharedPreferences.getInstance();
      await _pref.clear();
      await _pref.setString('_id', decode['User']['_id']);
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
      return Navigator.pop(context);
    }
  }

  static getProfil(String? id) async {
    var url = Uri.parse("http://192.168.1.3:8080/API/get-Profil/${id?.trim()}");
    print(id);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return Patient.fromjson(data);
  }

  static Future<dynamic> demandDoctor(Demand domand) async {
    var url = Uri.parse("http://192.168.1.3:8080/API/demandDoctor");
    var response = await http.post(url,
        headers: <String, String>{
          'context-type': 'application/json;charSet=UTF-8'
        },
        body: domand.toJson());

    var done = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Fluttertoast.showToast(
          msg:
              "Votre Demand ete bien enregistrer ,Please attend Reponse par Doctor",
          backgroundColor: Color.fromARGB(255, 103, 215, 107),
          timeInSecForIosWeb: 20);
    } else {
      Fluttertoast.showToast(
          msg: done['error'],
          backgroundColor: Color.fromARGB(255, 13, 96, 16),
          timeInSecForIosWeb: 20);
    }
  }

  static EditMyProfil(
    File? Image,
    String fullName,
    String number,
  ) async {
    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString('_id');
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.3:8080/API/update-Profil'),
      );

      if (Image != null && Image.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'imageProfil',
          Image.path,
        ));
      }

      request.fields['fullName'] = fullName;
      request.fields['tele'] = number;
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

  static Patient fromjson(Map<String, dynamic> json) {
    return Patient(
      complete_name: json['complete_name'].toString(),
      password: json['password'].toString(),
      tele: json['num_tele'].toString(),
      gender: json['gender'].toString(),
      image: json['avatar'] != null
          ? json['avatar'] as Map<String, dynamic>
          : null,
    );
  }
}
