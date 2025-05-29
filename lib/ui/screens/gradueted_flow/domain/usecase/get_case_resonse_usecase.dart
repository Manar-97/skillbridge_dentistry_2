import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/domain/repositories/case_repo.dart';

import '../../data/model/case_response_dm.dart';

@injectable
class GetCaseResponsesUseCase {
  final CaseRepository repository;

  GetCaseResponsesUseCase(this.repository);

  Future<Result<List<CaseResponseModel>>> call(int caseRequestId) {
    return repository.getCaseResponses(caseRequestId);
  }
}
