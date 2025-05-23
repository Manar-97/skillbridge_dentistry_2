import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/rate_vm.dart';
import 'model/consul_rating.dart';

class RatingScreen extends StatefulWidget {
  final int caseRequestId;

  const RatingScreen({super.key, required this.caseRequestId});
  static const String routeName = 'consulRate';

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    // جلب Cubit
    final ratingCubit = context.read<RatingCubit>();

    // أول ما الشاشة تبنيها، تجيب الـ consultants للتقييم
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ratingCubit.fetchConsultants(widget.caseRequestId);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Rate Consultants')),
      body: BlocConsumer<RatingCubit, RatingState>(
        listener: (context, state) {
          if (state is RatingSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rating submitted successfully!')),
            );
          } else if (state is RatingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is RatingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RatingLoaded) {
            final consultants = state.consultants;
            if (consultants.isEmpty) {
              return const Center(child: Text('No consultants found'));
            }
            return ListView.builder(
              itemCount: consultants.length,
              itemBuilder: (context, index) {
                final consultant = consultants[index];
                return ConsultantRatingTile(
                  consultant: consultant,
                  caseRequestId: widget.caseRequestId,
                );
              },
            );
          } else if (state is RatingSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RatingError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ConsultantRatingTile extends StatefulWidget {
  final ConsultantForRating consultant;
  final int caseRequestId;

  const ConsultantRatingTile({
    super.key,
    required this.consultant,
    required this.caseRequestId,
  });

  @override
  _ConsultantRatingTileState createState() => _ConsultantRatingTileState();
}

class _ConsultantRatingTileState extends State<ConsultantRatingTile> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    final ratingCubit = context.read<RatingCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(widget.consultant.name),
        subtitle: Row(
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            return IconButton(
              icon: Icon(
                starIndex <= _selectedRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _selectedRating = starIndex;
                });
              },
            );
          }),
        ),
        trailing: ElevatedButton(
          onPressed:
              _selectedRating == 0
                  ? null
                  : () {
                    ratingCubit.submitRating(
                      widget.caseRequestId,
                      widget.consultant.id,
                      _selectedRating,
                    );
                  },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
// void showRatingDialog(BuildContext context, int caseRequestId, String consultantId) {
//   int selectedRating = 3;
//
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("قيّم العلاج"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("ما تقييمك لجودة العلاج من الاستشاري؟"),
//             const SizedBox(height: 10),
//             StatefulBuilder(
//               builder: (context, setState) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(5, (index) {
//                     return IconButton(
//                       icon: Icon(
//                         index < selectedRating ? Icons.star : Icons.star_border,
//                         color: Colors.orange,
//                       ),
//                       onPressed: () => setState(() => selectedRating = index + 1),
//                     );
//                   }),
//                 );
//               },
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text("إلغاء"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<RatingCubit>().submitRating(
//                 caseRequestId,
//                 consultantId,
//                 selectedRating,
//               );
//               Navigator.of(context).pop();
//             },
//             child: const Text("إرسال"),
//           ),
//         ],
//       );
//     },
//   );
// }
