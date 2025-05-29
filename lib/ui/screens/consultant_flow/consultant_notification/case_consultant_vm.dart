import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/case_consultant_model.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/domain/usecase/get_cosultantId_usecase.dart';

@injectable
class CaseConsultantCubit extends Cubit<CaseConsultantState> {
  final GetCaseConsultantDataUseCase getCaseConsultantDataUseCase;

  CaseConsultantCubit(this.getCaseConsultantDataUseCase)
    : super(CaseConsultantInitial());

  Future<void> fetchCaseConsultants(int caseRequestId) async {
    emit(CaseConsultantLoading());
    final Result<List<CaseConsultantModel>> consultants =
        await getCaseConsultantDataUseCase(caseRequestId);
    consultants is Success<List<CaseConsultantModel>>
        ? emit(CaseConsultantLoaded(consultants.data!))
        : emit(
          CaseConsultantError(
            (consultants as ServerFailure).message ?? "Unknown error",
          ),
        );
  }
}

abstract class CaseConsultantState {}

class CaseConsultantInitial extends CaseConsultantState {}

class CaseConsultantLoading extends CaseConsultantState {}

class CaseConsultantLoaded extends CaseConsultantState {
  final List<CaseConsultantModel> consultants;

  CaseConsultantLoaded(this.consultants);
}

class CaseConsultantError extends CaseConsultantState {
  final String message;

  CaseConsultantError(this.message);
}
