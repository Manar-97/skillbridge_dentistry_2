class GenericResponseModel {
  final String? message;

  GenericResponseModel({this.message});

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) {
    return GenericResponseModel(message: json['message']);
  }
}
