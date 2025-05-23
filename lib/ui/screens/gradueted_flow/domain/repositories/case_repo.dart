import 'dart:io';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_request.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/case_response.dart';

abstract class CaseRepository {
  Future<Result<UploadCaseResponse>> uploadCase(UploadCaseRequest request);
}
