class ConsultantModel {
  final int id;
  final String name;
  final String specialization;

  ConsultantModel({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory ConsultantModel.fromJson(Map<String, dynamic> json) {
    return ConsultantModel(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
    );
  }
}

