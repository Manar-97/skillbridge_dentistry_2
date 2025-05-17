import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/response/pass_response.dart';
import '../../../Auth/domain/api_result.dart';
import '../../../Auth/domain/usecase/register_consultant_usecase.dart';

@injectable
class RegisterConsultantCubit extends Cubit<RegisterConsultantCubitState> {
  final RegisterConsultantUseCase registerConsultantUseCase;

  @factoryMethod
  RegisterConsultantCubit(this.registerConsultantUseCase)
      : super(RegisterConsultantInitial());

  Future<void> registerConsultant(
    String fullName,
    String email,
    String password,
    File resumePath,
    File photoPath,
    String yearOfExperience,
    String department,
    String biography,
  ) async {
    emit(AuthLoading());
    final Result<GenericResponseModel> result = await registerConsultantUseCase(
      fullName,
      email,
      password,
      resumePath,
      photoPath,
      yearOfExperience,
      department,
      biography,
    );
    result is Success<GenericResponseModel>
        ? emit(AuthSuccess(result.data!))
        : emit(
            AuthFailure((result as ServerFailure).message ?? "Unknown error"));
  }
}

abstract class RegisterConsultantCubitState {}

class RegisterConsultantInitial extends RegisterConsultantCubitState {}

class AuthLoading extends RegisterConsultantCubitState {}

class AuthSuccess extends RegisterConsultantCubitState {
  final GenericResponseModel cosultantRegistResponse;
  AuthSuccess(this.cosultantRegistResponse);
}

class AuthFailure extends RegisterConsultantCubitState {
  final String message;
  AuthFailure(this.message);
}
