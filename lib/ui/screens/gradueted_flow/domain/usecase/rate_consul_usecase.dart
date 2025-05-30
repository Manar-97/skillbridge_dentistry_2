import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/domain/repositories/case_repo.dart';

import '../../../Auth/domain/api_result.dart';

@injectable
class RateConsultantUseCase {
  final CaseRepository repository;

  RateConsultantUseCase(this.repository);

  Future<Result<void>> call(int caseConsultantId, String consultantId, int rate) {
    return repository.rateConsultant(caseConsultantId, consultantId, rate);
  }
}
