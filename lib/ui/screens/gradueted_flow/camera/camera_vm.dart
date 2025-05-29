import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../utils/core/shared_pref_hepler.dart';
import '../../Auth/domain/api_result.dart';
import '../data/model/case_request.dart';
import '../data/model/upload_case_response.dart';
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
      await SharedPrefHelper.setInt(
        'last_uploaded_case_id',
        result.data!.caseRequestId,
      );
      print('Saved caseRequestId==============${result.data!.caseRequestId}');
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
