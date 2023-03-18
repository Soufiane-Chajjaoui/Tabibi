// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Person.dart';

class Patient extends Person {
  Patient(
      {required super.cni,
      required super.tele,
      required super.complete_name,
      required super.password});

  // static Future<void> registre_patient(String? cni, String? tele,
  //     String? complete_name, String? password ) async {
  //   var url = Uri.parse("http://127.0.0.1:8080/signup_patient")
  //       .replace(host: "192.168.1.3");
  //   var res = await http.post(url, headers: <String, String>{
  //     'context-type': 'application/json;charSet=UTF-8'
  //   }, body: {
  //     'complete_name': complete_name,
  //     'CNI': cni,
  //     'num_tele': tele,
  //     'password': password,

  //   });
  //   if (res.statusCode == 200) {
  //     print(res.body);
  //   } else {
  //     print('A network error occurred');
  //   }
  //   // var req = await http.MultipartRequest(
  //   //     'POST',
  //   //     Uri.parse('http://127.0.0.1:8080/signup_patient')
  //   //         .replace(host: "192.168.1.3"));

  //   // req.files.add(await http.MultipartFile.fromPath('avatar', profil));
  //   // req.fields['complete_name'] = complete_name!;
  //   // req.fields['CNI'] = cni!;
  //   // req.fields['num_tele'] = tele!;
  //   // req.fields['password'] = password!;
  //   // var res = await req.send();
  // }
  static Future<void> registre_patient(
      String? cni,
      String? tele,
      String? complete_name,
      String? password,
      String? image,
      String? extension) async {
    var url = Uri.parse("http://127.0.0.1:8080/signup_patient")
        .replace(host: "192.168.1.3");
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'complete_name': complete_name,
      'CNI': cni,
      'num_tele': tele,
      'password': password,
      'avatar': image ?? 'vide',
      'extension': extension  ?? 'vide'
    });
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print('A network error occurred');
    }
  }

  static Future<bool> login_patient(String? tele, String? password) async {
    var url = Uri.parse("http://127.0.0.1:8080/login_patient")
        .replace(host: "192.168.1.3");
    var response = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'num_tele': tele,
      'password': password,
    });
    var decode = jsonDecode(response.body);
    return decode['message'];
  }
}
