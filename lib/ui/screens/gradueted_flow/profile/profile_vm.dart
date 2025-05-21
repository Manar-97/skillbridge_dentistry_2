import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';
import '../../Auth/data/repositories/auth_ds/auth_ds.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthOnlineDS authOnlineDS;

  ProfileCubit(this.authOnlineDS) : super(ProfileInitial());

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); // محاكاة تحميل
      final result = await authOnlineDS.fetchUserProfile();
      emit(ProfileSuccess(result!));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}

// login_state.dart

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess(this.userModel);
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}
