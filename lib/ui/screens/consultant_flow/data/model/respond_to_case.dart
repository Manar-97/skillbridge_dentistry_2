class RespondToCaseResponseModel {
  final String message;

  RespondToCaseResponseModel({required this.message});

  factory RespondToCaseResponseModel.fromJson(dynamic json) {
    // هنا نفترض أن json هو String وليس Map
    if (json is String) {
      return RespondToCaseResponseModel(message: json);
    }
    // لو كان خريطة:
    if (json is Map<String, dynamic>) {
      return RespondToCaseResponseModel(message: json['message'] ?? '');
    }
    return RespondToCaseResponseModel(message: '');
  }
}

class RespondToCaseRequestModel {
  final int caseConsultantId;
  final String diagnosis;
  final String treatment;
  final int caseRequestId;

  RespondToCaseRequestModel({
    required this.caseConsultantId,
    required this.diagnosis,
    required this.treatment,
    required this.caseRequestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'caseConsultantId': caseConsultantId,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'caseRequestId': caseRequestId,
    };
  }

  factory RespondToCaseRequestModel.fromJson(Map<String, dynamic> json) {
    return RespondToCaseRequestModel(
      caseConsultantId: json['caseConsultantId'],
      diagnosis: json['diagnosis'],
      treatment: json['treatment'],
      caseRequestId: json['caseRequestId'],
    );
  }
}
