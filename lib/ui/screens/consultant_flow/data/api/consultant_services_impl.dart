import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/respond_to_case.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/level/model/cosult_level_model.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import '../../../../utils/core/shared_pref_hepler.dart';
import '../model/case_consultant_model.dart';
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
      return RespondToCaseResponseModel.fromJson(response.data);
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

  @override
  Future<List<ConsultantLevel>> getConsultantLevels() async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      final response = await _dio.get(
        '${baseUrl}level/consultants/levels',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final List<dynamic> data = response.data;
      return data.map((json) => ConsultantLevel.fromJson(json)).toList();
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        print('Get Consultant Levels Error: $errorData');
      } else {
        print('Get Consultant Levels Error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<CaseConsultantModel>> getCaseConsultantData(
    int caseRequestId,
  ) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');
      print(
        'REQUEST[GET] => PATH: http://skillbridge1.runasp.net/api/RespondToCase/GetCaseConsultantsForCaseRequest/$caseRequestId',
      );

      final response = await _dio.get(
        '${baseUrl}RespondToCase/GetCaseConsultantsForCaseRequest/$caseRequestId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => CaseConsultantModel.fromJson(json))
            .toList();
      } else {
        print('Failed to load consultants: ${response.statusCode}');
        throw Exception('Failed to load case consultants');
      }
    } catch (e) {
      print('Error fetching consultants: $e');
      throw Exception('Error fetching consultants: $e');
    }
  }
}
