import '../../model/notifications_dm.dart';

abstract class NotificationsOnlineDS{
Future<List<NotificationModel>> getAllNotifications();
Future<int> getUnreadCount();
Future<void> markAllAsRead();
Future<void> markAsRead(int id);
Future<void> deleteNotification(int id);
}