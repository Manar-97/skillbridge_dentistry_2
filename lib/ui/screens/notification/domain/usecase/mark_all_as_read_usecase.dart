import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/notifications_repo.dart';

@injectable
class MarkAllAsReadUseCase {
  final NotificationsRepositories notificationsRepositories;

  MarkAllAsReadUseCase(this.notificationsRepositories);

  Future<Result<void>> call() {
    return notificationsRepositories.markAllAsRead();
  }
}
