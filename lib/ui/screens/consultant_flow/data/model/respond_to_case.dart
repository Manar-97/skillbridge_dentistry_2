class RespondToCaseResponseModel {
  final String message;

  RespondToCaseResponseModel({required this.message});

  factory RespondToCaseResponseModel.fromJson(Map<String, dynamic> json) {
    return RespondToCaseResponseModel(message: json['message'] ?? '');
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
