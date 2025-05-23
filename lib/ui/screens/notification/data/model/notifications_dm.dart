import '../../../consultant_flow/data/model/respond_to_case.dart';

class NotificationModel {
  final int? notificationId; // nullable int to handle null safely
  final String? title;
  final String? body;
  final bool? isRead;
  final DateTime? readAt;
  final DateTime? sentAt;

  NotificationModel({
    this.notificationId,
    this.title,
    this.body,
    this.isRead,
    this.readAt,
    this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId:
          json['notificationId'] != null ? json['notificationId'] as int : null,
      title: json['title'] as String?,
      body: json['body'] as String?,
      isRead: json['isRead'] as bool?,
      readAt: json['readAt'] != null ? DateTime.tryParse(json['readAt']) : null,
      sentAt: json['sentAt'] != null ? DateTime.tryParse(json['sentAt']) : null,
    );
  }
}
