// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project_pfe/actions/Reponse.dart';

Sous_urgance Sous_urganceFromJson(String str) =>
    Sous_urgance.fromJson(json.decode(str));

String Sous_urganceToJson(Sous_urgance data) => json.encode(data.toJson());

class Sous_urgance {
  String? libell;
  String? url;
  Reponse? reponse;
  String? id;

  Sous_urgance(
      {required this.libell,
      required this.url,
         this.reponse,
      required this.id});

 

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Sous_urgance.fromJson(Map<String, dynamic> json) => Sous_urgance(
        libell: json["libell"],
        url: json['name_Image']['url'],
        reponse: json["reponse"],
        id: json["_id"]
      );

  Map<String, dynamic> toJson() => {
        'libell': libell,
        'data_Image': url,
        'reponse' : reponse ,
        '_id' : id
      };
}
