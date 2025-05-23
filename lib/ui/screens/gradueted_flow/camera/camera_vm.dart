import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Auth/domain/api_result.dart';
import '../data/model/case_request.dart';
import '../data/model/case_response.dart';
import '../domain/usecase/upload_case_usecase.dart';

@injectable
class UploadCaseCubit extends Cubit<UploadCaseState> {
  final UploadCaseUseCase uploadCaseUseCase;

  @factoryMethod
  UploadCaseCubit(this.uploadCaseUseCase) : super(UploadCaseInitial());

  Future<void> uploadCase(UploadCaseRequest request) async {
    emit(UploadCaseLoading());
    final Result<UploadCaseResponse> result = await uploadCaseUseCase(request);
    if (result is Success<UploadCaseResponse>) {
      emit(UploadCaseSuccess(result.data!));
    } else if (result is ServerFailure) {
      emit(
        UploadCaseFailure((result as ServerFailure).message ?? "Unknown error"),
      );
    }
  }
}

// حالات الـ Cubit:
abstract class UploadCaseState {}

class UploadCaseInitial extends UploadCaseState {}

class UploadCaseLoading extends UploadCaseState {}

class UploadCaseSuccess extends UploadCaseState {
  final UploadCaseResponse response;

  UploadCaseSuccess(this.response);
}

class UploadCaseFailure extends UploadCaseState {
  final String message;

  UploadCaseFailure(this.message);
}
