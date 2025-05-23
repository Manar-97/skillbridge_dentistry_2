// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import '../Auth/data/model/response/user.dart';
//
//
// @injectable
// class UserCubit extends Cubit<UserState> {
//   @factoryMethod
//   UserCubit() : super(UserInitial());
//
//   void loadUser(UserModel user) {
//     emit(UserLoaded(user));
//   }
//
//   void updateUser(UserModel updatedUser) {
//     emit(UserLoaded(updatedUser));
//   }
//
//   void clearUser() {
//     emit(UserInitial());
//   }
// }
// abstract class UserState {}
//
// class UserInitial extends UserState {}
//
// class UserLoaded extends UserState {
//   final UserModel user;
//
//   UserLoaded(this.user);
// }
//
