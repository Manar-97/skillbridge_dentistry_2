import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Auth/domain/api_result.dart';
import '../data/model/case_response_dm.dart';
import '../domain/usecase/get_case_resonse_usecase.dart';

@injectable
class CaseResponseCubit extends Cubit<CaseResponseState> {
  final GetCaseResponsesUseCase getCaseResponsesUseCase;

  @factoryMethod
  CaseResponseCubit(this.getCaseResponsesUseCase)
    : super(CaseResponseInitial());

  Future<void> fetchCaseResponses(int caseRequestId) async {
    emit(CaseResponseLoading());

    final Result<List<CaseResponseModel>> result =
        await getCaseResponsesUseCase(caseRequestId);

    if (result is Success<List<CaseResponseModel>>) {
      emit(CaseResponseSuccess(result.data!));
    } else if (result is ServerFailure) {
      emit(
        CaseResponseFailure(
          (result as ServerFailure).message ?? 'Unknown Error',
        ),
      );
    }
  }
}

abstract class CaseResponseState {}

class CaseResponseInitial extends CaseResponseState {}

class CaseResponseLoading extends CaseResponseState {}

class CaseResponseSuccess extends CaseResponseState {
  final List<CaseResponseModel> responses;

  CaseResponseSuccess(this.responses);
}

class CaseResponseFailure extends CaseResponseState {
  final String message;

  CaseResponseFailure(this.message);
}
