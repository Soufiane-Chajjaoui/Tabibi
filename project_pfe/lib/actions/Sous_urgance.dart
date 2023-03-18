// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Sous_urgance Sous_urganceFromJson(String str) =>
    Sous_urgance.fromJson(json.decode(str));

String Sous_urganceToJson(Sous_urgance data) => json.encode(data.toJson());

class Sous_urgance {
  String? libell;
  String? data_Image;
  String? ext;
  String? id_reponse;
  String? id_urgance;

  Sous_urgance(
      {required this.libell,
      required this.data_Image,
      required this.ext,
      required this.id_reponse,
      required this.id_urgance});

  Future add_sous_urgance() async {
    var url = Uri.parse("http://127.0.0.1:8080/admin/add_Sous_Urgance")
        .replace(host: "192.168.1.3");
    var response = await http.post(url, headers: <String, String>{
          'context-type': 'application/json;charSet=UTF-8'
    }, body: 
       toJson()
     );
  }

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Sous_urgance.fromJson(Map<String, dynamic> json) => Sous_urgance(
        libell: json["libell"],
        data_Image: json["data_Image"],
        ext: json["ext"],
        id_reponse: json["id_reponse"],
        id_urgance: json["id_urgance"]
      );

  Map<String, dynamic> toJson() => {
        'libell': libell,
        'data_Image': data_Image,
        'extension': ext,
        'id_reponse' : id_reponse ,
        'id_urgance' : id_urgance
      };
}
