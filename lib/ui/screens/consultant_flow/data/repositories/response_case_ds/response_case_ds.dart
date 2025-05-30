import 'package:skillbridge_dentistry/ui/screens/consultant_flow/level/model/cosult_level_model.dart';

import '../../model/case_consultant_model.dart';
import '../../model/respond_to_case.dart';

abstract class ResponseCaseOnlineDS {
  Future<RespondToCaseResponseModel> responseCase(
    RespondToCaseRequestModel request,
  );
  Future<List<CaseConsultantModel>> getCaseConsultantData(int caseRequestId);
  Future<List<ConsultantLevel>> getConsultantLevels();
}

// abstract class ResponseCaseOfflineDS {
//   Future<void> saveUploadedCase(UploadedCaseModel caseData);
//   Future<UploadedCaseModel?> getUploadedCase();
// }
