// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Urgance UrganceFromJson(String str) => Urgance.fromJson(json.decode(str));

String UrganceToJson(Urgance data) => json.encode(data.toJson());

class Urgance {
  String? id;
  String? libell;
  String? url;

  Urgance({
    required this.id,
    required this.libell,
    required this.url
  });

  // static Future<void> add_Urgance(
  //     String? libell, String? data_Image, String? ext) async {
  //   // final urgance = Urgance(
  //   //     libell: libell, data_Image: data_Image, ext: ext);
  //   var url = Uri.parse("http://127.0.0.1:8080/admin/add_Urgance")
  //       .replace(host: "192.168.1.3");
  //   var response = await http.post(url, headers: <String, String>{
  //     'context-type': 'application/json;charSet=UTF-8'
  //   }, body: {
  //     'libell': libell,
  //     'data_Image': data_Image,
  //     'extension': ext
  //   });
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else
  //     print(response.body);
  // }

  // static get_urgance() async {
  //   List<Urgance> list = [];
  //   var url = Uri.parse('http://127.0.0.1:8080/admin/get_urgance')
  //       .replace(host: '192.168.1.3');
  //   final res = await http.get(url);
  //   if (res.statusCode == 200) {
  //     var data = jsonDecode(res.body);
  //     data['urgances'].forEach((value) => {
  //           list.add(Urgance(
  //               libell: value['info']['libell'],
  //               data_Image: value['Image'],
  //               ext: null))
  //         });
  //     return list;
  //   }
  //   return [];
  // }

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Urgance.fromJson(Map<String, dynamic> json) => Urgance(
        id: json['_id'],
        libell: json["libell"],
        url: json['name_Image']['url']
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'libell': libell,
        'url' : url
      };
}
