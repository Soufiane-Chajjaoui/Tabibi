class NotificationDemand {
  String? id;
  String? nameEmitter;
  String? idPatient;
  String? idReceiver;
  bool? isAccept;
  String? imageurl;
  NotificationDemand(
      {this.id,
      this.imageurl,
      this.nameEmitter,
      this.idPatient,
      this.idReceiver,
      this.isAccept});

  factory NotificationDemand.fromjson(Map<String, dynamic> json) =>
      NotificationDemand(
          imageurl: json["avatar"]["url"].toString(),
          id: json["demandPatient"]["_id"].toString(),
          idPatient: json["_id"].toString(),
          idReceiver: json["idReceiver"].toString(),
          isAccept: json["demandPatient"]["accepted"],
          nameEmitter: json["complete_name"].toString());
}
