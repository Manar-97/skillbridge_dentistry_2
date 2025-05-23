import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';

import '../../rating/model/consul_rating.dart';

abstract class GraduatedServices {
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request);
  Future<List<ConsultantForRating>> getConsultantsForRating(int caseRequestId);
  Future<void> rateConsultant(int caseRequestId, String consultantId, int rate);
}
