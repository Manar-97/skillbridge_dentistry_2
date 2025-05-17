class LoginResponseEntity {
  final String? message;
  final String? token;
  final UserEntity? user;

  LoginResponseEntity({
    this.message,
    this.token,
    this.user,
  });
}

class UserEntity {
  final String? Id;

  final String? username;

  final String? firstName;

  final String? lastName;

  final String? email;

  final String? phone;

  final List<String>? roles;

  final bool? isVerified;

  final String? createdAt;

  UserEntity({
    this.Id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.roles,
    this.isVerified,
    this.createdAt,
  });
}
