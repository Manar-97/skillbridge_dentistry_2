import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/fresh_grade_notification/fresh_notification_details_screen.dart';
import '../../../utils/core/shared_pref_hepler.dart';
import '../data/model/case_response_dm.dart';
import 'fresh_notification_vm.dart';

class FreshGraduatedNotification extends StatefulWidget {
  static const String routeName = 'freshNotification';

  const FreshGraduatedNotification({super.key});

  @override
  State<FreshGraduatedNotification> createState() =>
      _FreshGraduatedNotificationState();
}

class _FreshGraduatedNotificationState
    extends State<FreshGraduatedNotification> {
  int? caseRequestId;

  @override
  void initState() {
    super.initState();
    _loadCaseRequestIdAndFetch();
  }

  Future<void> _loadCaseRequestIdAndFetch() async {
    caseRequestId = await SharedPrefHelper.getInt('last_uploaded_case_id');
    if (caseRequestId != null) {
      context
          .read<FreshGraduatedNotificationCubit>()
          .fetchCaseResponses(caseRequestId!);
    } else {
      print("No caseRequestId found in shared preferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Notifications",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<FreshGraduatedNotificationCubit,
          FreshGraduatedNotificationState>(
        listener: (context, state) {
          if (state is FreshGraduatedNotificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<FreshGraduatedNotificationCubit,
            FreshGraduatedNotificationState>(
          builder: (context, state) {
            if (state is FreshGraduatedNotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FreshGraduatedNotificationFailure) {
              return Center(child: Text(state.message));
            } else if (state is FreshGraduatedNotificationSuccess) {
              final responses = state.responses;

              if (responses.isEmpty) {
                return const Center(
                  child: Text(
                    "No responses available yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: responses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final CaseResponseModel response = responses[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  response.consultantPhoto,
                                ),
                                onBackgroundImageError:
                                    (_, __) => const Icon(Icons.person),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      response.consultantName,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "⭐ ${response.rate.toStringAsFixed(1)}",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildSection("Biography", response.biography),
                          const SizedBox(height: 10),
                          _buildSection("Diagnosis", response.diagnosis),
                          const SizedBox(height: 10),
                          _buildSection("Treatment", response.treatment),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Unexpected state"));
          },
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF555555),
          ),
        ),
      ],
    );
  }
}
