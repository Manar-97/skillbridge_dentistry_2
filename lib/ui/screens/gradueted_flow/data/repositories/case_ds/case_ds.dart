import '../../model/case_request.dart';
import '../../model/case_response.dart';
import '../../model/uploaded_case.dart';

abstract class CaseOnlineDS {
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request);
}

abstract class CaseOfflineDS {
  Future<void> saveUploadedCase(UploadedCaseModel caseData);
  Future<UploadedCaseModel?> getUploadedCase();
}
