import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import '../../data/model/uploaded_case.dart';

@injectable
class SaveUploadedCaseUseCase {
  final CaseOfflineDS caseOfflineDS;

  SaveUploadedCaseUseCase(this.caseOfflineDS);

  Future<void> call(UploadedCaseModel caseModel) async {
    await caseOfflineDS.saveUploadedCase(caseModel);
  }
}
