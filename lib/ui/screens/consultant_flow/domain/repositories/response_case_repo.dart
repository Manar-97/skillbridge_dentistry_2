import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/respond_to_case.dart';

abstract class ResponseCaseRepository {
  Future<Result<RespondToCaseResponseModel>> responseCase(
    RespondToCaseRequestModel request,
  );
}
