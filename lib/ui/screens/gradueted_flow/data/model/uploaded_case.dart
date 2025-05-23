class UploadedCaseModel {
  final int id;
  final String title;
  final String? diagnosis;
  final String? imageUrl;

  UploadedCaseModel({
    required this.id,
    required this.title,
    this.diagnosis,
    this.imageUrl,
  });

  factory UploadedCaseModel.fromJson(Map<String, dynamic> json) {
    return UploadedCaseModel(
      id: json['id'],
      title: json['title'],
      diagnosis: json['diagnosis'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'diagnosis': diagnosis,
      'imageUrl': imageUrl,
    };
  }
}
