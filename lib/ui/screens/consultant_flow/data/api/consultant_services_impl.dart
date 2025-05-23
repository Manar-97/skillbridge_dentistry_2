import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/respond_to_case.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import '../../../../utils/core/shared_pref_hepler.dart';
import 'consultant_services.dart';

@Injectable(as: ConsultantServices)
class ConsultantServicesImpl implements ConsultantServices {
  final Dio _dio;
  final CaseOfflineDS caseOfflineDS;
  final String baseUrl = 'http://skillbridge1.runasp.net/api/';

  ConsultantServicesImpl(this._dio, this.caseOfflineDS);

  @override
  Future<RespondToCaseResponseModel> respondToCase(
    RespondToCaseRequestModel request,
  ) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');
      final response = await _dio.post(
        '${baseUrl}RespondToCase/respond-to-case',
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      final caseResponse = RespondToCaseResponseModel.fromJson(response.data);
      return caseResponse;
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        print('Response Case Error: $errorData');
      } else {
        print('Response Case Error: $e');
      }
      rethrow;
    }
  }
}
