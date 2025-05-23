import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';
import '../../../di/di.dart';
import '../consultant_flow/data/repositories/response_case_ds/response_case_ds.dart';
import 'notification_details_screen.dart';
import 'notification_vm.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  static const String routeName = 'notification';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _isLoadingDialogShowing = false;
  final responseCaseOnlineDS = getIt<ResponseCaseOnlineDS>();

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
                return const Center(child: Text('لا توجد إشعارات حالياً'));
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
                          notification.notificationId!,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم حذف الإشعار بنجاح')),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => NotificationDetailScreen(
                                        notification: notification,
                                        responseCaseOnlineDS:
                                            responseCaseOnlineDS,
                                      ),
                                ),
                              );
                            },
                            leading:
                                imageUrl != null
                                    ? CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(imageUrl),
                                      backgroundColor: Colors.grey.shade200,
                                      onBackgroundImageError:
                                          (_, __) => const Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                          ),
                                    )
                                    : CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                            title: Text(
                              notification.title ?? 'بدون عنوان',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              (notification.body?.trim().isNotEmpty ?? false)
                                  ? notification.body!
                                  : 'لا توجد رسالة',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // زر الـ Accept
                                IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => NotificationDetailScreen(
                                              notification: notification,
                                              responseCaseOnlineDS:
                                                  responseCaseOnlineDS,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                // زر الـ Reject
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (notification.notificationId != null) {
                                      context
                                          .read<NotificationsCubit>()
                                          .deleteNotification(
                                            notification.notificationId!,
                                          );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('تم حذف الإشعار بنجاح'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
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
                child: Text('حدث خطأ أثناء تحميل الإشعارات: ${state.message}'),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
