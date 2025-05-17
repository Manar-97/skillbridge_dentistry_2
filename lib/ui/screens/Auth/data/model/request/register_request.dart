import 'dart:io';

class ConsultantRegisterRequest {
  String? fullName;
  String? email;
  String? password;
  File? resumePath;
  String? yearOfExperience;
  String? department;
  String? biography;
  File? photoPath;

  ConsultantRegisterRequest({
    this.fullName,
    this.email,
    this.password,
    this.resumePath,
    this.yearOfExperience,
    this.department,
    this.biography,
    this.photoPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'yearOfExperience': yearOfExperience.toString(),
      'department': department,
      'shortBiography': biography,
    };
  }
}

class FreshGraduateRegisterRequest {
  String? fullName;
  String? email;
  String? password;
  String? yearOfGraduation;
  String? university;
  String? department;

  FreshGraduateRegisterRequest({
    this.fullName,
    this.email,
    this.password,
    this.yearOfGraduation,
    this.university,
    this.department,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'password': password,
        'yearOfGraduation': yearOfGraduation,
        'university': university,
        'department': department,
      };
}
