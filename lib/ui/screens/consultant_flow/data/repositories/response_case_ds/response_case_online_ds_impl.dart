import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/respond_to_case.dart';
import '../../api/consultant_services.dart';
import 'response_case_ds.dart';

@Injectable(as: ResponseCaseOnlineDS)
class ResponseCaseOnlineDSImpl implements ResponseCaseOnlineDS {
  final ConsultantServices consultantServices;
  ResponseCaseOnlineDSImpl(this.consultantServices);

  @override
  Future<RespondToCaseResponseModel> responseCase(
    RespondToCaseRequestModel request,
  ) {
    return consultantServices.respondToCase(request);
  }
}
