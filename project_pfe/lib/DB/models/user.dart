// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
const String tablePatient = 'Patient';
const String tableDoctor = 'Doctor';

class PatientFields {
  static List<String> values = [id, complete_name, tele, cni];
  static final String id = '_id';
  static final String complete_name = 'complete_name';
  static final String tele = 'tele';
  static final String cni = 'cni';
  // static final String image = 'image';
}

class DoctorFields {
  static final String id = '_id';
  static final String complete_name = 'complete_name';
  static final String tele = 'tele';
  static final String cni = 'cni';
  // static final String image = 'image';
  static final String mail = 'mail';
  static final String spec = 'spec';
}
