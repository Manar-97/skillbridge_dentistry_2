import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/repositories/response_case_repo_impl.dart';
import '../consultant_flow/data/model/respond_to_case.dart';
import '../consultant_flow/data/repositories/response_case_ds/response_case_ds.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/response_case_vm.dart';
import '../consultant_flow/domain/usecase/response_to_case_usecase.dart';
import 'data/model/notifications_dm.dart';

class NotificationDetailScreen extends StatefulWidget {
  final NotificationModel notification;
  final ResponseCaseOnlineDS responseCaseOnlineDS;

  const NotificationDetailScreen({
    super.key,
    required this.notification,
    required this.responseCaseOnlineDS,
  });

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  final TextEditingController treatmentController = TextEditingController();
  bool _isLoading = false;

  String? extractedImageUrl;
  String? diagnosisText;

  @override
  void initState() {
    super.initState();
    _parseNotificationBody();
  }

  void _parseNotificationBody() {
    final body = widget.notification.body ?? '';
    final regexUrl = RegExp(
      r'(http[s]?:\/\/\S+\.(?:png|jpg|jpeg|gif))',
      caseSensitive: false,
    );
    final match = regexUrl.firstMatch(body);
    extractedImageUrl = match?.group(0);

    if (extractedImageUrl != null) {
      diagnosisText = body.replaceAll(extractedImageUrl!, '').trim();
    } else {
      diagnosisText = body.trim();
    }
  }

  @override
  void dispose() {
    treatmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => RespondToCaseCubit(
            RespondToCaseUseCase(
              ResponseCaseRepositoryImpl(widget.responseCaseOnlineDS),
            ),
          ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Notification Details')),
        body: BlocListener<RespondToCaseCubit, RespondToCaseState>(
          listener: (context, state) {
            if (state is RespondToCaseLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is RespondToCaseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.response.message ?? 'Response sent successfully',
                  ),
                ),
              );
              Navigator.pop(context);
            }

            if (state is RespondToCaseError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Text(
                      widget.notification.title ?? 'No Title',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      diagnosisText ?? 'No details available',
                      style: GoogleFonts.inter(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    if (extractedImageUrl != null)
                      Image.network(
                        extractedImageUrl!,
                        errorBuilder:
                            (context, error, stackTrace) => Container(),
                      ),
                    const SizedBox(height: 20),
                    const Text(
                      'Enter Treatment:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: treatmentController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter treatment here',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final treatment = treatmentController.text.trim();
                        if (treatment.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter treatment'),
                            ),
                          );
                          return;
                        }

                        // Important: Set the correct values for caseConsultantId and caseRequestId from your data
                        final request = RespondToCaseRequestModel(
                          caseConsultantId: 0, // Set correct consultant ID
                          diagnosis: diagnosisText ?? 'No diagnosis',
                          treatment: treatment,
                          caseRequestId:
                              widget
                                  .notification
                                  .notificationId!, // Set correct request ID
                        );

                        context.read<RespondToCaseCubit>().sendResponse(
                          request,
                        );
                      },
                      child: const Text('Send Treatment'),
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
