import '../model/respond_to_case.dart';

abstract class ConsultantServices {
  Future<RespondToCaseResponseModel> respondToCase(
    RespondToCaseRequestModel request,
  );
}
