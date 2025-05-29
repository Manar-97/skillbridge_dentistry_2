class NotificationModel {
  final int notificationId; // nullable int to handle null safely
  final int? caseRequestId; // nullable int to handle null safely
  final int? caseConsultantId; // nullable int to handle null safely
  final String? title;
  final String? body;
  final bool? isRead;
  final DateTime? readAt;
  final DateTime? sentAt;

  NotificationModel({
    required this.caseRequestId,
    required this.caseConsultantId,
    required this.notificationId,
    this.title,
    this.body,
    this.isRead,
    this.readAt,
    this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      caseRequestId:
          json['caseRequestId'] != null ? json['caseRequestId'] as int : null,
      caseConsultantId:
          json['caseConsultantId'] != null
              ? json['caseConsultantId'] as int
              : null,
      notificationId: json['notificationId'],
      title: json['title'] as String?,
      body: json['body'] as String?,
      isRead: json['isRead'] as bool?,
      readAt: json['readAt'] != null ? DateTime.tryParse(json['readAt']) : null,
      sentAt: json['sentAt'] != null ? DateTime.tryParse(json['sentAt']) : null,
    );
  }
}
