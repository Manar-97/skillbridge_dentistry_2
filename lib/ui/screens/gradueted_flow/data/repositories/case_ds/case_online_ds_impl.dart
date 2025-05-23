import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/api/graduated_services.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/model/consul_rating.dart';
import 'case_ds.dart';

@Injectable(as: CaseOnlineDS)
class CaseOnlineDSImpl implements CaseOnlineDS {
  final GraduatedServices graduatedServices;
  CaseOnlineDSImpl(this.graduatedServices);

  @override
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request) {
    return graduatedServices.uploadCase(request);
  }

  @override
  Future<List<ConsultantForRating>> getConsultantsForRating(int caseRequestId) {
    return graduatedServices.getConsultantsForRating(caseRequestId);
  }

  @override
  Future<void> rateConsultant(
    int caseRequestId,
    String consultantId,
    int rate,
  ) {
    return graduatedServices.rateConsultant(caseRequestId, consultantId, rate);
  }
}
