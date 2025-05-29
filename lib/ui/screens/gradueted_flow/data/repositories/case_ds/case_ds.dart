import '../../../rating/model/consul_rating.dart';
import '../../model/case_request.dart';
import '../../model/case_response_dm.dart';
import '../../model/upload_case_response.dart';
import '../../model/uploaded_case.dart';

abstract class CaseOnlineDS {
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request);
  Future<List<ConsultantForRating>> getConsultantsForRating(int caseRequestId);
  Future<void> rateConsultant(int caseRequestId, String consultantId, int rate);
  Future<List<CaseResponseModel>> getCaseResponses(int caseRequestId);

}

abstract class CaseOfflineDS {
  Future<void> saveUploadedCase(UploadedCaseModel caseData);
  Future<UploadedCaseModel?> getUploadedCase();
}
