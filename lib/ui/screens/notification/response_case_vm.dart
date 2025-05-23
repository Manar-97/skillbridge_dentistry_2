import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../consultant_flow/data/model/respond_to_case.dart';
import '../consultant_flow/domain/usecase/response_to_case_usecase.dart';

@injectable
class RespondToCaseCubit extends Cubit<RespondToCaseState> {
  final RespondToCaseUseCase useCase;

  RespondToCaseCubit(this.useCase) : super(RespondToCaseInitial());

  Future<void> sendResponse(RespondToCaseRequestModel request) async {
    emit(RespondToCaseLoading());
    final result = await useCase.call(request);

    if (result is Success<RespondToCaseResponseModel>) {
      emit(RespondToCaseSuccess(result.data!));
    } else if (result is ServerFailure<RespondToCaseResponseModel>) {
      emit(RespondToCaseError(result.message ?? "Server error"));
    } else {
      emit(RespondToCaseError("Unexpected error"));
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
