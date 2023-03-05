// ignore_for_file: non_constant_identifier_names
import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Person.dart';

class Doctor extends Person {
  String? mail;
  String? speciality;

  Doctor(
      {required super.cni,
      required super.tele,
      required super.complete_name,
      required super.password,
      required this.mail,
      required this.speciality});
  static Future<void> registre_patient(String? cni, String? tele,
      String? complete_name, String? password , String? email , String? speciality) async {
    var url = Uri.parse("http://127.0.0.1:8080/signup_doctor")
        .replace(host: "192.168.1.4");
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'complete_name': complete_name,
      'CNI': cni,
      'num_tele': tele,
      'mail' : email ,
      'speciality' : speciality ,
      'password': password,
    });
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print('A network error occurred');
    }
    print(res.body);
  }
}
