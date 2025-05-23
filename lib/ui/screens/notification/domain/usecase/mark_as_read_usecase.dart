import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';

import '../repositories/notifications_repo.dart';

@injectable
class MarkAsReadUseCase {
  final NotificationsRepositories notificationsRepositories;

  MarkAsReadUseCase(this.notificationsRepositories);

  Future<Result<void>> call(int id) {
    return notificationsRepositories.markAsRead(id);
  }
}
