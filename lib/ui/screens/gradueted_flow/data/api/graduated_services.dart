import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';

abstract class GraduatedServices {
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request);
}
