import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/submit_rate_screen.dart';
import 'package:skillbridge_dentistry/ui/utils/appcolors.dart';
import '../fresh_grade_notification/conul_for_rating_vm.dart';

class ConsultantsRatingScreen extends StatefulWidget {
  final int caseRequestId;
  final String consultantName;

  const ConsultantsRatingScreen({
    super.key,
    required this.caseRequestId,
    required this.consultantName,
  });

  @override
  State<ConsultantsRatingScreen> createState() =>
      _ConsultantsRatingScreenState();
}

class _ConsultantsRatingScreenState extends State<ConsultantsRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultants Rating"),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<ConsultantsForRatingCubit, ConsultantsForRatingState>(
        builder: (context, state) {
          if (state is ConsultantsForRatingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ConsultantsForRatingLoaded) {
            final consultants = state.consultants;

            if (consultants.isEmpty) {
              return const Center(
                child: Text(
                  "No consultants available for rating.",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: consultants.length,
              itemBuilder: (context, index) {
                final consultant = consultants[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 5,
                  shadowColor: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${widget.consultantName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ID: ${consultant.consultantId}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SubmitRatingScreen(
                                    consultantId: consultant.consultantId,
                                    caseConsultantId: consultant.caseConsultantId,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: AppColors.mainColor,
                            ),
                            child: const Text(
                              "Rate Now",
                              style: TextStyle(fontSize: 16,color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ConsultantsForRatingError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
