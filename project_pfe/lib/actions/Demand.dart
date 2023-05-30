import 'dart:convert';

Demand DemandFromJson(String str) => Demand.fromJson(json.decode(str));

String DemandToJson(Demand data) => json.encode(data.toJson());

class Demand {
  String? id_patient;
  bool? accepted = false;

  Demand({required this.id_patient,  this.accepted});

  static isaccepted() async {}

  /*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
      id_patient: json["idPatient"],
       accepted: json["accepted"]);

  Map<String, dynamic> toJson() => {
        'id_patient': id_patient,
       };
}
