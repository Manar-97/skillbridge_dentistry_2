import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Auth/domain/api_result.dart';
import '../data/model/case_response_dm.dart';
import '../domain/usecase/get_case_resonse_usecase.dart';

@injectable
class FreshGraduatedNotificationCubit
    extends Cubit<FreshGraduatedNotificationState> {
  final GetCaseResponsesUseCase getCaseResponsesUseCase;

  FreshGraduatedNotificationCubit(this.getCaseResponsesUseCase)
    : super(FreshGraduatedNotificationInitial());

  // المتغير اللي هنخزن فيه الرد المختار
  CaseResponseModel? selectedResponse;

  // تحديد الرد المختار
  void selectResponse(CaseResponseModel response) {
    selectedResponse = response;
  }

  // جلب الردود من API
  Future<void> fetchCaseResponses(int caseRequestId) async {
    emit(FreshGraduatedNotificationLoading());

    final Result<List<CaseResponseModel>> result =
        await getCaseResponsesUseCase(caseRequestId);

    if (result is Success<List<CaseResponseModel>>) {
      final data = result.data;
      print("Fetched Data: $data");
      if (data != null && data.isNotEmpty) {
        emit(FreshGraduatedNotificationSuccess(data));
      } else {
        emit(FreshGraduatedNotificationFailure("لا توجد ردود حاليًا."));
      }
    } else if (result is ServerFailure) {
      emit(
        FreshGraduatedNotificationFailure(
          (result as ServerFailure).message ?? 'حدث خطأ في الاتصال بالخادم',
        ),
      );
    } else {
      emit(FreshGraduatedNotificationFailure("فشل غير متوقع"));
    }
  }
}

abstract class FreshGraduatedNotificationState {}

class FreshGraduatedNotificationInitial
    extends FreshGraduatedNotificationState {}

class FreshGraduatedNotificationLoading
    extends FreshGraduatedNotificationState {}

class FreshGraduatedNotificationSuccess
    extends FreshGraduatedNotificationState {
  final List<CaseResponseModel> responses;

  FreshGraduatedNotificationSuccess(this.responses);
}

class FreshGraduatedNotificationFailure
    extends FreshGraduatedNotificationState {
  final String message;

  FreshGraduatedNotificationFailure(this.message);
}
