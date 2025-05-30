import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/upload_case_response.dart';

import '../../rating/model/consul_rating.dart';
import '../model/case_response_dm.dart';

abstract class GraduatedServices {
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request);
  Future<List<ConsultantForRating>> getConsultantsForRating(int caseRequestId);
  Future<void> rateConsultant(int caseConsultantId, String consultantId, int rate);
  Future<List<CaseResponseModel>> getCaseResponses(int caseRequestId);
}
