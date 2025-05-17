class GenericResponseModel {
  final String message;

  GenericResponseModel({required this.message});

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) {
    return GenericResponseModel(
      message: json['message'] ?? '',
    );
  }
}
