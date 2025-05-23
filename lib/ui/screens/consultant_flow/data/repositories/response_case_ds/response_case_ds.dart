import '../../model/respond_to_case.dart';

abstract class ResponseCaseOnlineDS {
  Future<RespondToCaseResponseModel> responseCase(
    RespondToCaseRequestModel request,
  );
}

// abstract class ResponseCaseOfflineDS {
//   Future<void> saveUploadedCase(UploadedCaseModel caseData);
//   Future<UploadedCaseModel?> getUploadedCase();
// }
