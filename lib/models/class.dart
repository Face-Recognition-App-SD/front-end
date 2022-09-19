class Album {
  final String? firstname;
  //final String? lastname;
  // final int? phone;
  final String? password;
  //final String? cpass;
  // final int? ssn;
  // final String? address;
  // final String? org;

  Album({
    required this.firstname,
    // required this.lastname,
    // required this.phone,
    required this.password,
    // required this.cpass,
    // required this.ssn,
    // required this.address,
    // required this.org,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      firstname: json['firstname'],
      // lastname: json['lastname'],
      // phone: json['phone'],
      password: json['password'],
      // cpass: json['cpass'],
      // ssn: json['ssn'],
      // address: json['address'],
      // org: json['org'],
    );
  }
}
