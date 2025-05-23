import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';
import '../../rating/model/consul_rating.dart';

abstract class CaseRepository {
  Future<Result<UploadCaseResponse>> uploadCase(UploadCaseRequest request);
  Future<Result<List<ConsultantForRating>>> getConsultantsForRating(int caseRequestId);
  Future<Result<void>> rateConsultant(int caseRequestId, String consultantId, int rate);
}
