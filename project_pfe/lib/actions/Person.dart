// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types
import 'package:project_pfe/actions/Message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Person {
  String? id;
  String? complete_name;
  String? password;
  String? tele;
  String? gender;
  Map<String, dynamic>? image;

  static LogOut() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
  }

  Person(
      {this.id,
      required this.image,
      required this.tele,
      required this.gender,
      required this.complete_name,
      required this.password});

  static List<String> Genders = ['Male', 'Female'];

  static SendMessage(MessageChat message) async {
    var url = Uri.parse('http://192.168.1.3:8080/API/storeMessage');
    print(message.idSender);
    var res = await http.post(url,
        headers: <String, String>{
          'context-Type': 'application/json;charSet=UTF-8'
        },
        body: message.toJson());
    if (res.statusCode == 200) {
    } else {
      print(res.body);
    }
    print(res.body);
  }
}
