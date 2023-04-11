// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Reponse ReponseFromJson(String str) =>
    Reponse.fromJson(json.decode(str));

String ReponseToJson(Reponse data) => json.encode(data.toJson());

class Reponse {
  String? description;
  String? url;
  String? id;
 

  Reponse(
      {  
        this.description,
        this.url,
        this.id,
     });

 

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Reponse.fromJson(Map<String, dynamic> json) => Reponse(
        description: json["description"],
        url: json["url"],
        id: json["_id"]
        
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'url': url,
        'id': id 
      };
}
