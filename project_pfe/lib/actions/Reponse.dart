// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Reponse ReponseFromJson(String str) =>
    Reponse.fromJson(json.decode(str));

String ReponseToJson(Reponse data) => json.encode(data.toJson());

class Reponse {
  String? discription;
  String? data_Image;
  String? ext;
 

  Reponse(
      {required this.discription,
      required this.data_Image,
      required this.ext,
     });

  Future add_Reponse() async {
    var url = Uri.parse("http://127.0.0.1:8080/admin/add_Reponse")
        .replace(host: "192.168.1.3");
    var response = await http.post(url, headers: <String, String>{
          'context-type': 'application/json;charSet=UTF-8'
    }, body: 
       toJson()
     );
  }

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Reponse.fromJson(Map<String, dynamic> json) => Reponse(
        discription: json["discription"],
        data_Image: json["data_Image"],
        ext: json["ext"]
        
      );

  Map<String, dynamic> toJson() => {
        'discription': discription,
        'data_Image': data_Image,
        'extension': ext 
      };
}
