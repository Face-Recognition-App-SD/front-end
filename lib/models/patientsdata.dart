import 'dart:convert';

PatientsData patientFromJson(String str) =>
    PatientsData.fromJson(json.decode(str));
String patientToJson(PatientsData data) => json.encode(data.toJson());

class PatientsData {
  int? id;
  String? first_name;
  String? last_name;
  int? age;
  String? med_list;
  String? phone_number,
      date_of_birth,
      street_address,
      city_address,
      zipcode_address;
  String? state_address,
      link,
      creation_date,
      modified_date,
      emergency_contact_name,
      emergency_phone_number;
  String? relationship, gender;
  bool? is_in_hospital;
  List? tags;
  List? treatment;

  PatientsData({
    this.id,
    this.first_name,
    this.last_name,
    this.age,
    this.med_list,
    this.phone_number,
    this.date_of_birth,
    this.street_address,
    this.city_address,
    this.zipcode_address,
    this.state_address,
    this.link,
    this.creation_date,
    this.modified_date,
    this.emergency_contact_name,
    this.emergency_phone_number,
    this.relationship,
    this.gender,
    this.is_in_hospital,
    this.tags,
    this.treatment,
  });
  factory PatientsData.fromJson(Map<String, dynamic> json) {
    return PatientsData(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      age: json['age'],
      med_list: json['med_list'],
      phone_number: json['phone_number'],
      date_of_birth: json['date_of_birth'],
      street_address: json['street_address'],
      city_address: json['city_address'],
      state_address: json['state_address'],
      zipcode_address: json['zipcode_address'],
      link: json['link'],
      creation_date: json['creation_date'],
      modified_date: json['modified_date'],
      emergency_contact_name: json['emergency_contact_name'],
      emergency_phone_number: json['emergency_phone_number'],
      relationship: json['relationship'],
      gender: json['gender'],
      is_in_hospital: json['is_in_hospital'],
      tags: json['tags'],
      treatment: json['treatment'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name":first_name,
        "last_name": last_name,
        "age": age,
        "med_list": med_list,
        "phone_number":phone_number,
        "date_of_birth": date_of_birth,
        "street_address": street_address,
        "city_address": city_address,
        "zipcode_address": zipcode_address,
        "state_address": state_address,
        "link": link,
        "creation_date": creation_date,
        "modified_date": modified_date,
        "emergency_contact_name": emergency_contact_name,
        "emergency_phone_number": emergency_phone_number,
        "relationship": relationship,
        "gender": gender,
        "is_in_hospital": is_in_hospital,
        "tags": tags,
        "treatment": treatment
      };
}
