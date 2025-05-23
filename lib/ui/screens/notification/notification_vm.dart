import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/data/model/notifications_dm.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
import 'domain/usecase/delete_notifications_usecase.dart';
import 'domain/usecase/get_all_notifications_usecase.dart';
import 'domain/usecase/get_unread_count_usecase.dart';
import 'domain/usecase/mark_all_as_read_usecase.dart';
import 'domain/usecase/mark_as_read_usecase.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  final GetAllNotificationsUseCase getAllNotificationsUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;

  NotificationsCubit({
    required this.getAllNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markAllAsReadUseCase,
    required this.markAsReadUseCase,
    required this.deleteNotificationUseCase,
  }) : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    final Result<List<NotificationModel>> result =
        await getAllNotificationsUseCase.call();

    if (result is Success<List<NotificationModel>>) {
      emit(NotificationsLoaded(result.data!));
    } else if (result is ServerFailure<List<NotificationModel>>) {
      emit(NotificationsError(result.message ?? "Unknown error"));
    } else {
      emit(NotificationsError("Unexpected error"));
    }
  }

  Future<void> markAllRead() async {
    emit(NotificationsLoading());
    final result = await markAllAsReadUseCase.call();
    if (result is Success) {
      await loadNotifications();
    } else if (result is ServerFailure) {
      emit(NotificationsError(result.message ?? 'Failed to mark all as read'));
    } else {
      emit(NotificationsError('Unexpected error'));
    }
  }

  Future<void> markAsRead(int id) async {
    emit(NotificationsLoading());
    final result = await markAsReadUseCase.call(id);
    if (result is Success) {
      await loadNotifications();
    } else if (result is ServerFailure) {
      emit(NotificationsError(result.message ?? 'Failed to mark as read'));
    } else {
      emit(NotificationsError('Unexpected error'));
    }
  }

  Future<void> deleteNotification(int id) async {
    await deleteNotificationUseCase.call(id);
    await loadNotifications();
  }
}

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String message;

  NotificationsError(this.message);
}
