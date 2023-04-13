// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_declarations

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:project_pfe/DB/models/user.dart';
import 'package:project_pfe/actions/Demand.dart';
import 'package:project_pfe/actions/Person.dart';
import 'package:project_pfe/actions/Reponse.dart';
import 'package:project_pfe/actions/Sous_urgance.dart';
import 'package:project_pfe/actions/Urgance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Patient extends Person {
  Patient(
      {super.id,
      required super.cni,
      required super.tele,
      required super.complete_name,
      required super.password});

  Patient copy(
      {int? id,
      String? complete_name,
      String? password,
      String? cni,
      String? tele}) {
    return Patient(
        id: id ?? this.id,
        cni: cni ?? this.cni,
        tele: tele ?? this.tele,
        complete_name: complete_name ?? this.complete_name,
        password: password ?? this.password);
  }

  static Future<void> registre_patient(
    String? cni,
    String? tele,
    String? complete_name,
    String? password,
  ) async {
    var url = Uri.parse("http://192.168.1.4:8080/signup_patient")
        // .replace(host: "192.168.1.3")
        ;
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'complete_name': complete_name,
      'CNI': cni,
      'num_tele': tele,
      'password': password,
    });
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print('A network error occurred');
    }
  }

  static getUrgance() async {
    List<Urgance> list = [];
    var url = Uri.parse('http://192.168.1.4:8080/API/get_urgance');

    var res = await http.get(url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      //  print(data);
      data.forEach((value) => {
            list.add(Urgance(
                libell: value['libell'],
                id: value['_id'],
                url: value['name_Image']['url']))
          });
      return list;
    }
    return [];
  }

  static get_sous_urgance(String id) async {
    List<Sous_urgance> list = [];

    var url = Uri.parse("http://192.168.1.4:8080/API/get_sous_urgance/${id}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      data.forEach((element) => {list.add(Sous_urgance.fromJson(element))});
      return list;
    } else {
      return [];
    }
  }

  static get_reponse(String id) async {
    List<Reponse> list = [];
    var url = Uri.parse("http://192.168.1.4:8080/API/get_reponse/${id}");

    var rep = await http.get(url);

    if (rep.statusCode == 200) {
      var data = jsonDecode(rep.body);
      data.forEach((element) {
        list.add(Reponse(
            description: element['description'],
            url: element['name_Image']['url']));
      });
      list.add(Reponse(description: '', url: ''));
      return list;
    } else
      return [];
  }

  static Future<Map<String, dynamic>> login_patient(
      String? tele, String? password) async {
    var url = Uri.parse("http://192.168.1.4:8080/login_patient")
        // .replace(host: "192.168.1.3")
        ;
    var response = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'num_tele': tele,
      'password': password,
    });
    var decode = jsonDecode(response.body);
    return decode;
  }

  static getProfil(String? id) async {
    var url = Uri.parse("http://192.168.1.4:8080/API/get-Profil/${id}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    return Patient.fromjson(data);
  }

  static demandDoctor(Demand domand) async {
    var url = Uri.parse("http://192.168.1.4:8080/API/demandDoctor");
    var response = await http.post(url,
        headers: <String, String>{
          'context-type': 'application/json;charSet=UTF-8'
        },
        body: domand.toJson());

    // var done = jsonDecode(response.body);
    // return done['reponse'];
  }

  Map<String, dynamic> toJson() => {
        PatientFields.id: id,
        PatientFields.complete_name: complete_name,
        PatientFields.cni: cni,
        PatientFields.tele: tele,
      };

  static Patient fromjson(Map<String, dynamic> json) {
    return Patient(
        cni: json['id'],
        tele: json['tele'],
        complete_name: json['complete_name'],
        password: json['password']);
  }
}
