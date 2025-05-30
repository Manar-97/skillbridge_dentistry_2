import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../../../../di/di.dart';
import '../data/model/case_response_dm.dart';
import '../data/model/upload_case_response.dart';
import '../rating/rate_vm.dart';
import '../rating/rating.dart';
import 'conul_for_rating_vm.dart';
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
    final box = Hive.box<UploadCaseResponse>('upload_case_response');
    final response = box.get('last_upload_response');

    setState(() {
      caseRequestId = response?.caseRequestId;
    });

    if (caseRequestId != null) {
      context.read<FreshGraduatedNotificationCubit>().fetchCaseResponses(
        caseRequestId!,
      );
      print('caseRequestId from Hive: $caseRequestId');
    } else {
      print("No caseRequestId found in Hive");
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
          "Notification",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocListener<
        FreshGraduatedNotificationCubit,
        FreshGraduatedNotificationState
      >(
        listener: (context, state) {
          if (state is FreshGraduatedNotificationFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<
          FreshGraduatedNotificationCubit,
          FreshGraduatedNotificationState
        >(
          builder: (context, state) {
            if (state is FreshGraduatedNotificationInitial ||
                state is FreshGraduatedNotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FreshGraduatedNotificationFailure) {
              return Center(child: Text(state.message));
            } else if (state is FreshGraduatedNotificationSuccess) {
              final responses = state.responses;
              if (responses.isEmpty) {
                return const Center(
                  child: Text("No responses available for this case."),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: responses.length,
                itemBuilder: (context, index) {
                  final CaseResponseModel response = responses[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            // داخل onTap في قائمة الردود:
                            onTap: () {
                              if (caseRequestId == null) {
                                print("caseRequestId is null");
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create:
                                                (_) =>
                                                    getIt<
                                                        ConsultantsForRatingCubit
                                                      >()
                                                      ..fetchConsultants(
                                                        caseRequestId!,
                                                      ),
                                          ),
                                          BlocProvider(
                                            create: (_) => getIt<RatingCubit>(),
                                          ),
                                        ],
                                        child: ConsultantsRatingScreen(
                                          caseRequestId: caseRequestId!,
                                          consultantName: response.consultantName,
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    response.consultantPhoto,
                                  ),
                                  onBackgroundImageError:
                                      (_, __) => const Icon(Icons.person),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      response.consultantName,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "⭐ ${response.rate.toStringAsFixed(1)}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Biography:",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(response.biography),
                          const SizedBox(height: 8),
                          Text(
                            "Diagnosis:",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(response.diagnosis),
                          const SizedBox(height: 8),
                          Text(
                            "Treatment:",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(response.treatment),
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
}
