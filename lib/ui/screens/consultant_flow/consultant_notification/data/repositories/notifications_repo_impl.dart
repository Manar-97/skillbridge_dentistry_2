import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/data/model/notifications_dm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/data/repositories/notifications_ds/notifications_ds.dart';
import '../../domain/repositories/notifications_repo.dart';

@Injectable(as: NotificationsRepositories)
class NotificationsRepositoriesImpl implements NotificationsRepositories {
  final NotificationsOnlineDS notificationsOnlineDS;
  NotificationsRepositoriesImpl(this.notificationsOnlineDS);
  @override
  Future<Result<void>> deleteNotification(int id) async {
    try {
      final response = await notificationsOnlineDS.deleteNotification(id);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<List<NotificationModel>>> getAllNotifications() async {
    try {
      final response = await notificationsOnlineDS.getAllNotifications();
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<int>> getUnreadCount() async {
    try {
      final response = await notificationsOnlineDS.getUnreadCount();
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<void>> markAllAsRead() async {
    try {
      final response = await notificationsOnlineDS.markAllAsRead();
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<Result<void>> markAsRead(int id) async {
    try {
      final response = await notificationsOnlineDS.markAsRead(id);
      return Success(response);
    } on DioException catch (e) {
      return ServerFailure.fromDioError(e);
    } catch (e) {
      return ServerFailure(e.toString());
    }
  }
}
