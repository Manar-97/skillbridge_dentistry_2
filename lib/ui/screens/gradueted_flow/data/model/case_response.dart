import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/uploaded_case.dart';

class UploadCaseResponse {
  final String message;
  final int caseRequestId;
  final String prediction;
  final double confidence;
  final String treatment;

  UploadCaseResponse({
    required this.message,
    required this.caseRequestId,
    required this.prediction,
    required this.confidence,
    required this.treatment,
  });

  factory UploadCaseResponse.fromJson(Map<String, dynamic> json) {
    return UploadCaseResponse(
      message: json['message'],
      caseRequestId: json['caseRequestId'],
      prediction: json['prediction'],
      confidence: (json['confidence'] as num).toDouble(),
      treatment: json['treatment'],
    );
  }
}

// دالة تحويل
extension UploadedCaseResponseExtension on UploadCaseResponse {
  UploadedCaseModel toModel() {
    return UploadedCaseModel(
      id: caseRequestId,
      title: prediction,
      diagnosis: treatment,
      imageUrl: null, // لو عندك رابط صورة تقدر تحطه هنا، لو لا خليها null
    );
  }
}
