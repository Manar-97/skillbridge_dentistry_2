class ConsultantForRating {
  final String consultantId;
  final int caseConsultantId;

  ConsultantForRating({
    required this.consultantId,
    required this.caseConsultantId,
  });

  factory ConsultantForRating.fromJson(Map<String, dynamic> json) {
    return ConsultantForRating(
      consultantId: json['consultantId'] ?? '',
      caseConsultantId: json['caseConsultantId'] ?? '',
    );
  }
}
