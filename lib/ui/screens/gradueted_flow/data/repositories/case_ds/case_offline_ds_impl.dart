import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/uploaded_case.dart';

import '../../../../../utils/core/shared_pref_hepler.dart';
import '../../model/upload_case_response.dart';
import 'case_ds.dart';

@Injectable(as: CaseOfflineDS)
class CaseOfflineDSImpl implements CaseOfflineDS {
  @override
  Future<UploadedCaseModel?> getUploadedCase() async {
    await SharedPrefHelper.getUploadedCase();
    return null;
  }

  @override
  Future<void> saveUploadedCase(UploadCaseResponse response) async {
    final box = Hive.box<UploadCaseResponse>('upload_case_response');
    await box.put('last_upload_response', response);
    print('UploadCaseResponse saved with caseRequestId: ${response.caseRequestId}');
  }

  @override
  Future<UploadCaseResponse?> getLastUploadCaseResponse() async {
    final box = Hive.box<UploadCaseResponse>('upload_case_response');
    return box.get('last_upload_response');
  }
}
