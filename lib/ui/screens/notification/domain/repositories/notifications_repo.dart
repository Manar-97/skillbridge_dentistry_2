import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../../data/model/notifications_dm.dart';

abstract class NotificationsRepositories {
  Future<Result<List<NotificationModel>>> getAllNotifications();
  Future<Result<int>> getUnreadCount();
  Future<Result<void>> markAllAsRead();
  Future<Result<void>> markAsRead(int id);
  Future<Result<void>> deleteNotification(int id);
}
