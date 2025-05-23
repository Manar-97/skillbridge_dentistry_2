import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/model/consul_rating.dart';
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

  @override
  Future<List<ConsultantForRating>> getConsultantsForRating(
    int caseRequestId,
  ) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      final response = await _dio.get(
        '${baseUrl}Rating/consultants-for-rating/$caseRequestId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final List<dynamic> data = response.data;

      final consultants =
          data
              .map((jsonItem) => ConsultantForRating.fromJson(jsonItem))
              .toList();

      return consultants;
    } catch (e) {
      if (e is DioException) {
        print('Get Consultants Error: ${e.response?.data}');
      } else {
        print('Get Consultants Error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> rateConsultant(
    int caseRequestId,
    String consultantId,
    int rate,
  ) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      final response = await _dio.post(
        '${baseUrl}Rating/rate-consultant',
        data: {
          'caseRequestId': caseRequestId,
          'consultantId': consultantId,
          'rate': rate,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Rating Response: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('Rate Consultant Error: ${e.response?.data}');
      } else {
        print('Rate Consultant Error: $e');
      }
      rethrow;
    }
  }
}
