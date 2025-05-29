import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/response_to_case_vm.dart';
import '../data/model/respond_to_case.dart';
import 'data/model/notifications_dm.dart';

class ConsultantNotificationDetailScreen extends StatefulWidget {
  final NotificationModel notification;

  const ConsultantNotificationDetailScreen({super.key, required this.notification});

  @override
  State<ConsultantNotificationDetailScreen> createState() =>
      _ConsultantNotificationDetailScreenState();
}

class _ConsultantNotificationDetailScreenState extends State<ConsultantNotificationDetailScreen> {
  final TextEditingController _treatmentController = TextEditingController();

  @override
  void dispose() {
    _treatmentController.dispose();
    super.dispose();
  }

  // استخراج صورة من النص
  String? extractImageUrl(String body) {
    final RegExp regExp = RegExp(
      r'(http[s]?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp))',
      caseSensitive: false,
    );
    return regExp.firstMatch(body)?.group(0);
  }

  void _sendResponse(BuildContext context) {
    final treatment = _treatmentController.text.trim();

    if (treatment.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter treatment')));
      return;
    }

    final requestModel = RespondToCaseRequestModel(
      caseConsultantId: widget.notification.caseConsultantId!,
      diagnosis: widget.notification.body!,
      treatment: treatment,
      caseRequestId: widget.notification.caseRequestId!,
    );

    context.read<RespondToCaseCubit>().responseToCase(requestModel);
  }

  @override
  Widget build(BuildContext context) {
    final sentDate =
        widget.notification.sentAt != null
            ? '${widget.notification.sentAt!.day}/${widget.notification.sentAt!.month}/${widget.notification.sentAt!.year}'
            : 'Date Not Found';

    final imageUrl = extractImageUrl(widget.notification.body ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Details',
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RespondToCaseCubit, RespondToCaseState>(
        listener: (context, state) {
          if (state is RespondToCaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Response sent successfully')),
            );
            _treatmentController.clear();
          } else if (state is RespondToCaseError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          final isLoading = state is RespondToCaseLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notification.title ?? "No Title",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.notification.body ?? "No Body",
                      style: GoogleFonts.inter(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    if (imageUrl != null) ...[
                      Center(
                        child: Image.network(
                          imageUrl,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Text("No image"),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    Text(
                      'Sent At: $sentDate',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Treatment:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: _treatmentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter treatment',
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child:
                          isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                onPressed: () {
                                  _sendResponse(context);
                                },
                                child: const Text("Send Treatment"),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
