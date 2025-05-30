class UserModel {
  final String id;
  final String token;
  final String userName;
  final String email;
  final String fullName;
  final String role;
  final UserData data;

  UserModel({
    required this.token,
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.role,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      token: json['token'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      role: json['role'] ?? '',
      data: UserData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'role': role,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final String university;
  final String department;
  final int yearsOfGraduation;
  final int yearOfExperience;
  final String? profilePicturePath;
  final String? resumeLink;
  final String? consultantId;
  final String? freshGradId;

  UserData({
    required this.university,
    required this.department,
    required this.yearsOfGraduation,
    required this.yearOfExperience,
    this.profilePicturePath,
    this.resumeLink,
    this.consultantId,
    this.freshGradId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      university: json['university'] ?? '',
      department: json['department'] ?? '',
      yearsOfGraduation: _parseYearOfGraduation(json['yearsOfGraduation']),
      yearOfExperience: _parseYearOfExperience(json['yearOfExperience']),
      profilePicturePath: json['profilePicturePath'] ?? '',
      resumeLink: json['resumeLink'] ?? '',
      consultantId: json['consultantId'] as String?,
      freshGradId: json['freshGradId'] as String?,
    );
  }
  static int _parseYearOfExperience(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static int _parseYearOfGraduation(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'university': university,
      'department': department,
      'yearsOfGraduation': yearsOfGraduation,
      'yearOfExperience': yearOfExperience,
      'profilePicturePath': profilePicturePath,
      'resumeLink': resumeLink,
      'consultantId': consultantId,
      'freshGradId': freshGradId,
    };
  }
}
