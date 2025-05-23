import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import '../repositories/notifications_repo.dart';

@injectable
class GetUnreadCountUseCase {
  final NotificationsRepositories notificationsRepositories;

  GetUnreadCountUseCase(this.notificationsRepositories);

  Future<Result<int>> call() {
    return notificationsRepositories.getUnreadCount();
  }
}
