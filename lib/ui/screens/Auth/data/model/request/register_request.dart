import 'dart:io';

import 'package:dio/dio.dart';

class ConsultantRegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final File resumePath;
  final String yearOfExperience;
  final String department;
  final String biography;
  final File photoPath;

  ConsultantRegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.resumePath,
    required this.yearOfExperience,
    required this.department,
    required this.biography,
    required this.photoPath,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'FullName': fullName,
      'Email': email,
      'Password': password,
      'ResumeLink': await MultipartFile.fromFile(resumePath.path),
      'YearOfExperience': yearOfExperience,
      'Department': department,
      'ShortBiography': biography,
      'Photo': await MultipartFile.fromFile(photoPath.path),
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'yearOfExperience': yearOfExperience,
      'department': department,
      'shortBiography': biography,
    };
  }
}

class FreshGraduateRegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String yearOfGraduation;
  final String university;
  final String department;

  FreshGraduateRegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.yearOfGraduation,
    required this.university,
    required this.department,
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
