import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/case_consultant_model.dart';
import '../repositories/response_case_repo.dart';

@injectable
class GetCaseConsultantDataUseCase {
  final ResponseCaseRepository repository;

  GetCaseConsultantDataUseCase(this.repository);

  Future<Result<List<CaseConsultantModel>>> call(int caseRequestId) async {
    return await repository.getCaseConsultantData(caseRequestId);
  }
}
