import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';

import '../repositories/notifications_repo.dart';

@injectable
class DeleteNotificationUseCase {
  final NotificationsRepositories notificationsRepositories;

  DeleteNotificationUseCase(this.notificationsRepositories);

  Future<Result<void>> call(int id) {
    return notificationsRepositories.deleteNotification(id);
  }
}
