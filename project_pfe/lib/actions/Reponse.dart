// ignore_for_file: camel_case_types
import 'dart:convert';
 

Reponse ReponseFromJson(String str) => Reponse.fromJson(json.decode(str));

String ReponseToJson(Reponse data) => json.encode(data.toJson());

class Reponse {
  String? description;
  String? url;
  String? id;
  String? moreDetails;

  Reponse({
    this.description,
    this.url,
    this.id,
    this.moreDetails
  });

/*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Reponse.fromJson(Map<String, dynamic> json) => Reponse(
      description: json["description"], url: json["name_Image"]["url"], id: json["_id"] , moreDetails: json["moreDetails"]["details"] , );

  Map<String, dynamic> toJson() =>
      {'description': description, 'url': url, 'id': id};
}
