class ForgetPasswordRequest {
  String? email;

  ForgetPasswordRequest({this.email});

  Map<String, dynamic> toJson() => {'email': email};

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRequest(
      email: json['email'],
    );
  }
}

class ResetPasswordRequest {
  String? email;
  String? token;
  String? newPassword;
  String? confirmPassword;

  ResetPasswordRequest({
    this.email,
    this.token,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      email: json['email'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
