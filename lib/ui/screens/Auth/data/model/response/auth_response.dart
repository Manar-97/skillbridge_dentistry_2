import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';

class AuthResponse {
  final String? message; // موجود في register فقط
  final UserModel user;
  final String token;

  AuthResponse({this.message, required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'],
      user: UserModel.fromJson(json['user'] ?? json),
      token: json['token'] ?? '',
    );
  }
}
