import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/domain/repositories/case_repo.dart';

import '../../../Auth/domain/api_result.dart';
import '../../rating/model/consul_rating.dart';

@injectable
class GetConsultantsForRatingUseCase {
  final CaseRepository repository;

  GetConsultantsForRatingUseCase(this.repository);

  Future<Result<List<ConsultantForRating>>> call(int caseRequestId) {
    return repository.getConsultantsForRating(caseRequestId);
  }
}
