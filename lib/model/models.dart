class DoctorsModel {
  String doctorId;
  String fullName;
  String district;
  String email;
  String phoneNumber;
  String gender;
  String? image;

  DoctorsModel({
    required this.doctorId,
    required this.fullName,
    required this.district,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.image,
  });

  factory DoctorsModel.fromMap(Map<String, dynamic> map) {
    return DoctorsModel(
        doctorId: map['doctorId'],
        fullName: map['fullName'],
        district: map['district'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        gender: map['gender']);
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'fullName': fullName,
      'district': district,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender
    };
  }
}
