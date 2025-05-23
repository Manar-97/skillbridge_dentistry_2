class RateConsultantRequestModel {
  final int caseRequestId;
  final String consultantId;
  final int rate;

  RateConsultantRequestModel({
    required this.caseRequestId,
    required this.consultantId,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    return {
      'caseRequestId': caseRequestId,
      'consultantId': consultantId,
      'rate': rate,
    };
  }
}
