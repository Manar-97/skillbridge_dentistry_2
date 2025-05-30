import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/model/respond_to_case.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/repositories/response_case_ds/response_case_ds.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/level/model/cosult_level_model.dart';
import '../../domain/repositories/response_case_repo.dart';
import '../model/case_consultant_model.dart';

@Injectable(as: ResponseCaseRepository)
class ResponseCaseRepositoryImpl implements ResponseCaseRepository {
  final ResponseCaseOnlineDS responseCaseOnlineDS;

  ResponseCaseRepositoryImpl(this.responseCaseOnlineDS);

  @override
  Future<Result<RespondToCaseResponseModel>> responseCase(
    RespondToCaseRequestModel request,
  ) async {
    try {
      final response = await responseCaseOnlineDS.responseCase(request);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<List<CaseConsultantModel>>> getCaseConsultantData(
    int caseRequestId,
  ) async {
    try {
      final response = await responseCaseOnlineDS.getCaseConsultantData(
        caseRequestId,
      );
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<List<ConsultantLevel>>> getConsultantLevels() async {
    try {
      final response = await responseCaseOnlineDS.getConsultantLevels();
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }
}
