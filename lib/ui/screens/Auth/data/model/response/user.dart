// import 'dart:io';
//
// import '../login_response_entity.dart';
//
// /// email : "nadeen.ismail429@gmail.com"
// /// roles : ["Consultant"]
// /// token : "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5NjRmMTNkLTE3MDUtNDM3Ni04YmRhLTc5OTg3OTA0OTc2NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Im5hZGVlbi5pc21haWw0MjlAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoibmFkZWVubiIsInN1YiI6IjU5NjRmMTNkLTE3MDUtNDM3Ni04YmRhLTc5OTg3OTA0OTc2NCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNvbnN1bHRhbnQiLCJleHAiOjE3NTIyNDUzODQsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMzQvIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NzIzNC8ifQ.q-L9XRmeMCKIyAPwXNA6L77vH4Dr8awW-v-bIKE0uNk"
// class User {
//   final String? id;
//   final String? username;
//   final String? email;
//   final List<String>? roles;
//   final bool? isVerified;
//   final String? token;
//   final File? resumePath;
//   final File? photoPath;
//   final String? yearOfExperience;
//   final String? department;
//   final String? biography;
//
//   User({
//     this.resumePath,
//     this.photoPath,
//     this.yearOfExperience,
//     this.department,
//     this.biography,
//     this.id,
//     this.username,
//     this.isVerified,
//     this.email,
//     this.roles,
//     this.token,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       resumePath: json['resumePath'],
//       photoPath: json['photoPath'],
//       yearOfExperience: json['yearOfExperience'],
//       department: json['department'],
//       biography: json['biography'],
//       id: json['_id'],
//       username: json['username'],
//       isVerified: json['isVerified'],
//       token: json['token'],
//       roles: json['roles'] != null ? json['roles'].cast<String>() : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['email'] = email;
//     map['username'] = username;
//     map['isVerified'] = isVerified;
//     map['roles'] = roles;
//     map['token'] = token;
//     map['resumePath'] = resumePath;
//     map['photoPath'] = photoPath;
//     map['yearOfExperience'] = yearOfExperience;
//     map['department'] = department;
//     map['biography'] = biography;
//     return map;
//   }
//
//   UserEntity toDomain() {
//     return UserEntity(
//       Id: id,
//       username: username,
//       email: email,
//       roles: roles,
//       isVerified: isVerified,
//     );
//   }
// }
