class ConsultantLevel {
  final String id;
  final String name;

  ConsultantLevel({required this.id, required this.name});

  factory ConsultantLevel.fromJson(Map<String, dynamic> json) {
    return ConsultantLevel(
      id: json['id'],
      name: json['name'],
    );
  }
}
