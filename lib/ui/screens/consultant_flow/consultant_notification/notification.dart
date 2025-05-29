import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';
import 'notification_details_screen.dart';
import 'notification_vm.dart';

class ConsultantNotifications extends StatefulWidget {
  const ConsultantNotifications({super.key});
  static const String routeName = 'consultantNotification';

  @override
  State<ConsultantNotifications> createState() =>
      _ConsultantNotificationsState();
}

class _ConsultantNotificationsState extends State<ConsultantNotifications> {
  bool _isLoadingDialogShowing = false;

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
  }

  void showLoadingDialog() {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }
  }

  void hideLoadingDialog() {
    if (_isLoadingDialogShowing) {
      _isLoadingDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  String? extractImageUrl(String body) {
    final RegExp regExp = RegExp(
      r'(http[s]?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp))',
      caseSensitive: false,
    );
    return regExp.firstMatch(body)?.group(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF13122B),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsLoading) {
            showLoadingDialog();
          } else {
            hideLoadingDialog();
          }
          if (state is NotificationsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoaded) {
              final notifications = state.notifications;
              if (notifications.isEmpty) {
                return const Center(child: Text('No notifications available'));
              }
              return RefreshIndicator(
                onRefresh:
                    () =>
                        context.read<NotificationsCubit>().loadNotifications(),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final imageUrl = extractImageUrl(notification.body ?? '');

                    // في داخل ListView.builder في الـ itemBuilder

                    return Dismissible(
                      key: Key(notification.notificationId.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context.read<NotificationsCubit>().deleteNotification(
                          notification.notificationId,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notification deleted successfully'),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.commentBgrColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading:
                                imageUrl != null
                                    ? Image.network(
                                      imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    )
                                    : null,
                            title: Text(notification.title ?? "No Title"),
                            subtitle: Text(notification.body ?? ""),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ConsultantNotificationDetailScreen(
                                        notification: notification,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            if (state is NotificationsError) {
              return Center(
                child: Text(
                  'Error while loading notifications: ${state.message}',
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
