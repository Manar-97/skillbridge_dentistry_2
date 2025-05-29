import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../data/model/respond_to_case.dart';
import '../domain/usecase/response_to_case_usecase.dart';

@injectable
class RespondToCaseCubit extends Cubit<RespondToCaseState> {
  final RespondToCaseUseCase respondUseCase;

  RespondToCaseCubit(this.respondUseCase) : super(RespondToCaseInitial());

  Future<RespondToCaseResponseModel?> responseToCase(
    RespondToCaseRequestModel request,
  ) async {
    emit(RespondToCaseLoading());

    final response = await respondUseCase.call(request);

    if (response is Success<RespondToCaseResponseModel>) {
      emit(RespondToCaseSuccess(response.data!));
      return response.data;
    } else if (response is ServerFailure) {
      emit(
        RespondToCaseError(
          (response as ServerFailure).message ?? "Server error",
        ),
      );
      return null;
    } else {
      emit(RespondToCaseError("Unexpected error"));
      return null;
    }
  }
}

abstract class RespondToCaseState {}

class RespondToCaseInitial extends RespondToCaseState {}

class RespondToCaseLoading extends RespondToCaseState {}

class RespondToCaseSuccess extends RespondToCaseState {
  final RespondToCaseResponseModel response;

  RespondToCaseSuccess(this.response);
}

class RespondToCaseError extends RespondToCaseState {
  final String message;

  RespondToCaseError(this.message);
}
