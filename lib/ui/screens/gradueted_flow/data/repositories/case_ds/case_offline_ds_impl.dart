import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/uploaded_case.dart';

import '../../../../../utils/core/shared_pref_hepler.dart';
import 'case_ds.dart';

@Injectable(as: CaseOfflineDS)
class CaseOfflineDSImpl implements CaseOfflineDS {
  @override
  Future<UploadedCaseModel?> getUploadedCase() async {
    await SharedPrefHelper.getUploadedCase();
    return null;
  }

  @override
  Future<void> saveUploadedCase(UploadedCaseModel caseData) async {
    await SharedPrefHelper.saveUploadedCase(caseData);
  }
}
