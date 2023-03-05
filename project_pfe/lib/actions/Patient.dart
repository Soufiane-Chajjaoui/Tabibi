// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Person.dart';

class Patient extends Person {
  Patient(
      {required super.cni,
      required super.tele,
      required super.complete_name,
      required super.password});

  static Future<void> registre_patient(String? cni, String? tele,
      String? complete_name, String? password) async {
    var url = Uri.parse("http://127.0.0.1:8080/signup_patient")
        .replace(host: "192.168.1.3");
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
