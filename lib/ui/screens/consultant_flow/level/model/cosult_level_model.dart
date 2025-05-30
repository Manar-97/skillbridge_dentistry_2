class ConsultantLevel {
  final String fullName;
  final double rate;
  final String shortBiography;
  final String photoUrl;

  ConsultantLevel({
    required this.fullName,
    required this.rate,
    required this.shortBiography,
    required this.photoUrl,
  });

  factory ConsultantLevel.fromJson(Map<String, dynamic> json) {
    return ConsultantLevel(
      fullName: json['fullName'],
      rate: (json['rate'] as num).toDouble(),
      shortBiography: json['shortBiography'],
      photoUrl: json['photoUrl'],
    );
  }
}
