import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/domain/repositories/case_repo.dart';
import '../../data/model/case_request.dart';
import '../../data/model/upload_case_response.dart';
import '../../../Auth/domain/api_result.dart';

@injectable
class UploadCaseUseCase {
  final CaseRepository caseRepository;

  UploadCaseUseCase(this.caseRepository);

  Future<Result<UploadCaseResponse>> call(UploadCaseRequest request) async {
    return caseRepository.uploadCase(request);
  }
}
