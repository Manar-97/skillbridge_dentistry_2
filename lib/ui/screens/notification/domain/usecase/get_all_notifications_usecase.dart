import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/domain/repositories/notifications_repo.dart';
import '../../../Auth/domain/api_result.dart';
import '../../data/model/notifications_dm.dart';

@injectable
class GetAllNotificationsUseCase {
  final NotificationsRepositories notificationsRepositories;
  GetAllNotificationsUseCase(this.notificationsRepositories);

  Future<Result<List<NotificationModel>>> call() {
    return notificationsRepositories.getAllNotifications();
  }
}
