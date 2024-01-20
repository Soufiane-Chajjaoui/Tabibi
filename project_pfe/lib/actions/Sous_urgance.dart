// ignore_for_file: camel_case_types
import 'dart:convert';
 
Sous_urgance Sous_urganceFromJson(String str) =>
    Sous_urgance.fromJson(json.decode(str));

String Sous_urganceToJson(Sous_urgance data) => json.encode(data.toJson());

class Sous_urgance {
  String? libell;
  String? url;
   String? id;

  Sous_urgance(
      {required this.libell,
      required this.url,
       required this.id});

 

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Sous_urgance.fromJson(Map<String, dynamic> json) => Sous_urgance(
        libell: json["libell"],
        url: json['name_Image']['url'],
         id: json["_id"]
      );

  Map<String, dynamic> toJson() => {
        'libell': libell,
        'data_Image': url,
         '_id' : id
      };
}
