import 'dart:convert';
import 'dart:io';

Demand DemandFromJson(String str) => Demand.fromJson(json.decode(str));

String DemandToJson(Demand data) => json.encode(data.toJson());

class Demand {
  String? id_patient;
  String? id_urgance;
  bool? accepted = false;

  Demand({required this.id_patient, required this.id_urgance, this.accepted});

  static isaccepted() async {}

  /*++++++++++++++++++++  convert Json +++++++++++++++++++++++++*/
  factory Demand.fromJson(Map<String, dynamic> json) => Demand(
      id_patient: json["idPatient"],
      id_urgance: json["Urgance_name"],
      accepted: json["accepted"]);

  Map<String, dynamic> toJson() => {
        'id_patient': id_patient,
        'Urgance_name': id_urgance,
      };
}
