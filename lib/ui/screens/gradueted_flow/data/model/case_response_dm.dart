class CaseResponseModel {
  final String consultantName;
  final String consultantPhoto;
  final String biography;
  final String diagnosis;
  final String treatment;
  final double rate;

  CaseResponseModel({
    required this.consultantName,
    required this.consultantPhoto,
    required this.biography,
    required this.diagnosis,
    required this.treatment,
    required this.rate,
  });

  factory CaseResponseModel.fromJson(Map<String, dynamic> json) {
    return CaseResponseModel(
      consultantName: json['consultantName'],
      consultantPhoto: json['consultantPhoto'],
      biography: json['biography'],
      diagnosis: json['diagnosis'],
      treatment: json['treatment'],
      rate: (json['rate'] as num).toDouble(),
    );
  }
}
