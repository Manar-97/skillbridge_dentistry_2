import '../../level/model/cosult_level_model.dart';
import '../model/case_consultant_model.dart';
import '../model/respond_to_case.dart';

abstract class ConsultantServices {
  Future<RespondToCaseResponseModel> respondToCase(
    RespondToCaseRequestModel request,
  );
  Future<List<ConsultantLevel>> getConsultantLevels();

  Future<List<CaseConsultantModel>> getCaseConsultantData(int caseRequestId);
}
