import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/data/api/notifications_services.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/data/model/notifications_dm.dart';

import 'notifications_ds.dart';

@Injectable(as: NotificationsOnlineDS)
class NotificationsOnlineDSImpl implements NotificationsOnlineDS {
  final NotificationsServices notificationsServices;

  NotificationsOnlineDSImpl(this.notificationsServices);
  @override
  Future<void> deleteNotification(int id) {
    return notificationsServices.deleteNotification(id);
  }

  @override
  Future<List<NotificationModel>> getAllNotifications() {
    return notificationsServices.getAllNotifications();
  }

  @override
  Future<int> getUnreadCount() {
    return notificationsServices.getUnreadCount();
  }

  @override
  Future<void> markAllAsRead() {
    return notificationsServices.markAllAsRead();
  }

  @override
  Future<void> markAsRead(int id) {
    return notificationsServices.markAsRead(id);
  }
}
