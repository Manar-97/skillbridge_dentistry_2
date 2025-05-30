import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response_dm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/upload_case_response.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/model/consul_rating.dart';
import '../../domain/repositories/case_repo.dart';

@Injectable(as: CaseRepository)
class CaseRepositoryImpl implements CaseRepository {
  final CaseOnlineDS caseOnlineDS;
  CaseRepositoryImpl(this.caseOnlineDS);
  @override
  Future<Result<UploadCaseResponse>> uploadCase(
    UploadCaseRequest request,
  ) async {
    try {
      final response = await caseOnlineDS.uploadCase(request);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<List<ConsultantForRating>>> getConsultantsForRating(
    int caseRequestId,
  ) async {
    try {
      final response = await caseOnlineDS.getConsultantsForRating(
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
  Future<Result<void>> rateConsultant(
    int caseConsultantId,
    String consultantId,
    int rate,
  ) async {
    try {
      await caseOnlineDS.rateConsultant(caseConsultantId, consultantId, rate);
      return Success(null);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<List<CaseResponseModel>>> getCaseResponses(
    int caseRequestId,
  ) async {
    try {
      final responses = await caseOnlineDS.getCaseResponses(caseRequestId);
      return Success(responses);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }
}
