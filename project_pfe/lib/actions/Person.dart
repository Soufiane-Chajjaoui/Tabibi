// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types
import 'package:objectid/objectid.dart';
class Person {
  int? id;
  String? complete_name;
  String? password;
  String? cni;
  String? tele;

  Person(
      {
      this.id ,
      required this.cni,
      required this.tele,
      required this.complete_name,
      required this.password});


}
