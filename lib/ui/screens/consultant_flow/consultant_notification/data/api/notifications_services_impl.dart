import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/data/model/notifications_dm.dart';
import '../../../../../utils/core/shared_pref_hepler.dart';
import 'notifications_services.dart';

@Injectable(as: NotificationsServices)
class NotificationsServicesImpl implements NotificationsServices {
  final Dio _dio;
  final String baseUrl = 'http://skillbridge1.runasp.net/api/';

  NotificationsServicesImpl(this._dio);
  @override
  Future<void> deleteNotification(int id) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      await _dio.delete(
        '${baseUrl}Notifications/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      if (e is DioException) {
        print('Delete notification error: ${e.response?.data}');
      } else {
        print('Delete notification error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');
      print('📌 TOKEN USED: $token');
      final response = await _dio.get(
        '${baseUrl}Notifications',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      if (e is DioException) {
        print('Get notifications error: ${e.response?.data}');
      } else {
        print('Get notifications error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');
      final response = await _dio.get(
        '${baseUrl}Notifications/unread-count',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return response.data['count'] ?? 0;
      } else {
        throw Exception('Failed to fetch unread count');
      }
    } catch (e) {
      if (e is DioException) {
        print('Unread count error: ${e.response?.data}');
      } else {
        print('Unread count error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      await _dio.post(
        '${baseUrl}Notifications/mark-all-read',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        print('Mark all as read error: ${e.response?.data}');
      } else {
        print('Mark all as read error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> markAsRead(int id) async {
    try {
      final token = await SharedPrefHelper.getSecureString('token');

      await _dio.post(
        '${baseUrl}Notifications/mark-as-read/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      if (e is DioException) {
        print('Mark as read error: ${e.response?.data}');
      } else {
        print('Mark as read error: $e');
      }
      rethrow;
    }
  }
}
