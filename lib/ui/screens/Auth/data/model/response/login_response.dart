class LoginResponse {
  final String? message;
  final String token;
  final int? userId;

  LoginResponse({this.userId, this.message, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    map['userId'] = userId;
    return map;
  }

  // LoginResponseEntity toDomain() {
  //   return LoginResponseEntity(
  //     message: message,
  //     token: token,
  //     userId: userId,
  //   );
  // }
}
