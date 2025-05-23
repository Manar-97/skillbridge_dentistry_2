class ConsultantForRating {
  final String id;
  final String name;

  ConsultantForRating({required this.id, required this.name});

  factory ConsultantForRating.fromJson(Map<String, dynamic> json) {
    return ConsultantForRating(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
