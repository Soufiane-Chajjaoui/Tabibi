import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_pfe/actions/Notification.dart';
import 'package:project_pfe/actions/Person.dart';
import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/UserChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agent extends Person {
  String? mail;
  Agent(
      {required super.image,
      required super.tele,
      this.mail,
      required super.gender,
      required super.complete_name,
      required super.password});

  static Future<List<NotificationDemand>> getNotifications() async {
    List<NotificationDemand> notifications = [];
    var url = Uri.parse('http://192.168.1.3:8080/API/notifications');
    var res = await http.get(url);

    var decode = jsonDecode(res.body);

    if (res.statusCode == 200) {
      decode.forEach((element) {
        print(element["complete_name"]);
        notifications.add(NotificationDemand.fromjson(element));
      });
      return notifications;
    } else {
      return [];
    }
  }

  static Future<dynamic> acceptDemand(String? id, String? idPatient) async {
    final _pref = await SharedPreferences.getInstance();
    final idAgent = await _pref.getString("_id");
    var url = Uri.parse(
        'http://192.168.1.3:8080/API/AccepteDemand/${id}/${idAgent}/${idPatient}');
    var res = await http.put(url);
    var decode = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      return Fluttertoast.showToast(
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

  static ShareWithDoctor(String idDoctor, String idPatient) async {
    final url = Uri.parse(
        'http://192.168.1.3:8080/API/ShareWithDoctor/${idDoctor.trim()}/${idPatient.trim()}');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Votre demande ete bien enregistre',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 137, 144, 83),
        textColor: Colors.white,
        fontSize: 17.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Problem de connexion try again',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(225, 218, 63, 52),
        textColor: const Color.fromARGB(255, 235, 197, 197),
        fontSize: 17.0,
      );
    }
  }

  static getDoctors() async {
    List<UserChat> DoctorsList = [];
    var url = Uri.parse("http://192.168.1.3:8080/API/getDoctors");
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      data.forEach((element) => DoctorsList.add(UserChat.fromJson(element)));
      return DoctorsList;
    } else {
      return [];
    }
  }

  static Future<dynamic> getPatientChat() async {
    List<UserChat> listChatUsers = [];
    var url = Uri.parse('http://192.168.1.3:8080/API/get-Patients-chat');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decode = jsonDecode(res.body);
      decode
          .forEach((element) => listChatUsers.add(UserChat.fromJson(element)));
      return listChatUsers;
    } else
      return [];
  }

  static Future<dynamic> LoginAgent(
      String? tele, String? password, context) async {
    var url = Uri.parse('http://192.168.1.3:8080/API/loginAgent');

    var res = await http.post(url,
        headers: {'context-Type': 'application/json;charSet=UTF-8'},
        body: {"tele": tele?.trim(), "password": password?.trim()});
    var decode = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final _pref = await SharedPreferences.getInstance();
      _pref.clear();
      await _pref.setString('_id', decode['Agent']['_id']);
      await _pref.setBool('isAgent', true);
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

  static Future<Agent> getProfil() async {
    final _pref = await SharedPreferences.getInstance();
    final id = _pref.getString('_id');
    print(id);
    var url = Uri.parse('http://192.168.1.3:8080/API/getProfil-Agent/${id}');
    var res = await http.get(url);
    var agent = jsonDecode(res.body);
    print(agent);
    return Agent.fromJson(agent);
  }

  static ModifyProfil(
      File? Image, String fullName, String number, String email) async {
    var url = Uri.parse('http://192.168.1.3:8080/API/update-profil-agent');
    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString('_id');

    try {
      var request = http.MultipartRequest('POST', url);
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

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        complete_name: json['complete_name'],
        tele: json['num_tele'].toString(),
        image: json['avatar'] != null
            ? json['avatar'] as Map<String, dynamic>
            : null,
        mail: json['mail'],
        password: json['password'],
        gender: json['gender'],
      );
  static Future<dynamic> removeDemand(id) async {
    var url = Uri.parse('http://192.168.1.3:8080/API/remove-demand/$id');
    print(id);
    var res = await http.delete(url);
    var decode = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return true;
    } else {
      return Fluttertoast.showToast(
        msg: "${decode["error"]}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 219, 101, 92),
        textColor: Colors.white,
        fontSize: 17.0,
      );
      ;
    }
  }
}
