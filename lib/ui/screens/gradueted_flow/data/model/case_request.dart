import 'dart:io';
import 'package:dio/dio.dart';

class UploadCaseRequest {
  final String diagnose;
  final File imageFile;

  UploadCaseRequest({required this.diagnose, required this.imageFile});

  Future<FormData> toFormData() async {
    final fileName = imageFile.path.split('/').last;

    return FormData.fromMap({
      'diagnose': diagnose,
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
  }
}
