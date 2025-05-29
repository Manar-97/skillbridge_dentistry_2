class CaseConsultantModel {
  final int caseConsultantId;
  final String consultantName;
  final String consultantPhoto;
  final String shortBiography;
  final double rate;
  final String consultantId;

  CaseConsultantModel({
    required this.caseConsultantId,
    required this.consultantName,
    required this.consultantPhoto,
    required this.shortBiography,
    required this.rate,
    required this.consultantId,
  });

  factory CaseConsultantModel.fromJson(Map<String, dynamic> json) {
    return CaseConsultantModel(
      caseConsultantId: json['caseConsultantId'],
      consultantName: json['consultantName'],
      consultantPhoto: json['consultantPhoto'],
      shortBiography: json['shortBiography'],
      rate: json['rate']?.toDouble() ?? 0.0,
      consultantId: json['consultantId'],
    );
  }
}
