import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/domain/repositories/response_case_repo.dart';

import '../../data/model/respond_to_case.dart';

@injectable
class RespondToCaseUseCase {
  final ResponseCaseRepository repository;

  RespondToCaseUseCase(this.repository);

  Future<Result<RespondToCaseResponseModel>> call(
    RespondToCaseRequestModel request,
  ) async {
    return await repository.responseCase(request);
  }
}
