import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import '../../../../utils/core/shared_pref_hepler.dart';
import 'graduated_services.dart';

@Injectable(as: GraduatedServices)
class GraduatedServicesImpl implements GraduatedServices {
  final Dio _dio;
  final CaseOfflineDS caseOfflineDS;
  final String baseUrl = 'http://skillbridge1.runasp.net/api/';

  GraduatedServicesImpl(this._dio, this.caseOfflineDS);

  @override
  Future<UploadCaseResponse> uploadCase(UploadCaseRequest request) async {
    try {
      final formData = await request.toFormData();
      final response = await _dio.post(
        '${baseUrl}CaseRequests/upload-case-request',
        data: formData,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${await SharedPrefHelper.getSecureString('token')}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final caseResponse = UploadCaseResponse.fromJson(response.data);

      // ✅ لو محتاج تخزن شيء بعد الرفع، أضفه هنا
      await caseOfflineDS.saveUploadedCase(caseResponse.toModel());

      return caseResponse;
    } catch (e) {
      if (e is DioException) {
        print('Upload Case Error: ${e.response?.data}');
      } else {
        print('Upload Case Error: $e');
      }
      rethrow;
    }
  }
}
