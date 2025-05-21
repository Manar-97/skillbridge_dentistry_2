import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/user.dart';
import '../../Auth/data/repositories/auth_ds/auth_ds.dart';

@injectable
class ConsultantProfileCubit extends Cubit<ConsultantProfileState> {
  final AuthOnlineDS authOnlineDS;

  ConsultantProfileCubit(this.authOnlineDS) : super(ConsultantProfileInitial());

  Future<void> fetchUserData() async {
    emit(ConsultantProfileLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); // محاكاة تحميل
      final result = await authOnlineDS.fetchUserProfile();
      emit(ConsultantProfileSuccess(result!));
    } catch (e) {
      emit(ConsultantProfileFailure(e.toString()));
    }
  }
}

// login_state.dart

abstract class ConsultantProfileState {}

class ConsultantProfileInitial extends ConsultantProfileState {}

class ConsultantProfileLoading extends ConsultantProfileState {}

class ConsultantProfileSuccess extends ConsultantProfileState {
  final UserModel userModel;
  ConsultantProfileSuccess(this.userModel);
}

class ConsultantProfileFailure extends ConsultantProfileState {
  final String message;
  ConsultantProfileFailure(this.message);
}
