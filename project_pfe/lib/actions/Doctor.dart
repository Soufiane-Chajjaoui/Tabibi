// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Person.dart';

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

  Doctor({
    required super.cni,
    required super.tele,
    required super.complete_name,
    required super.password,
    required this.mail,
    required this.spec,
  });

  static Future<bool> registre_doctor(
    String? email,
    String? complete_name,
    String? password,
    String? speciality,
  ) async {
    var url = Uri.parse("http://192.168.1.4:8080/signup_doctor");
    var res = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      // I use Firebase so I don't need it
      // 'complete_name': complete_name,
      // 'CNI': cni,
      // 'num_tele': tele,
      // 'mail': email,
      // 'speciality': speciality,
      // 'password': password,
      // 'avatar': image ?? 'vide',
      // 'extension': extension ?? 'vide',
    });
    // if (res.statusCode == 200) {
    //   print(res.body);
    // } else {
    //   print('A network error occurred');
    // }
    var response = jsonDecode(res.body);
    return response['response'];
  }

  static Future<bool> login_doctor(String? email, String? password) async {
    var url = Uri.parse("http://192.168.1.4:8080/login_doctor");
    var response = await http.post(url, headers: <String, String>{
      'context-type': 'application/json;charSet=UTF-8'
    }, body: {
      'email': email,
      'password': password,
    });
    var decode = jsonDecode(response.body);
    return decode['message'];
  }
}
