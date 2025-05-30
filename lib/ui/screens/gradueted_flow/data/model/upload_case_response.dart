import 'package:hive/hive.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/uploaded_case.dart';
part 'upload_case_response.g.dart';

@HiveType(
  typeId: 1,
) // typeId رقم فريد (لو 0 استخدمته لـ UploadedCaseModel استعمل 1 هنا)
class UploadCaseResponse {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final int caseRequestId;

  @HiveField(2)
  final String prediction;

  @HiveField(3)
  final double confidence;

  @HiveField(4)
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

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'caseRequestId': caseRequestId,
      'prediction': prediction,
      'confidence': confidence,
      'treatment': treatment,
    };
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
