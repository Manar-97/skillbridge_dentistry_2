import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import '../../data/model/uploaded_case.dart';

@injectable
class GetUploadedCaseUseCase {
  final CaseOfflineDS caseOfflineDS;

  GetUploadedCaseUseCase(this.caseOfflineDS);

  Future<UploadedCaseModel?> call() async {
    return await caseOfflineDS.getUploadedCase();
  }
}
