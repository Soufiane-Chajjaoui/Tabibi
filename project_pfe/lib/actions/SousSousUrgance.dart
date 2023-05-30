// ignore_for_file: camel_case_types
import 'dart:convert'; 

SousSousUrganceobj SousSousUrganceobjFromJson(String str) =>
    SousSousUrganceobj.fromJson(json.decode(str));

class SousSousUrganceobj {
  String? id;
  String? libell;
  String? url;

  SousSousUrganceobj({this.id, this.libell, this.url});
  factory SousSousUrganceobj.fromJson(Map<String, dynamic> json) =>
      SousSousUrganceobj(
          id: json["_id"], libell: json["libell"], url: json["image"]["url"]);
}
