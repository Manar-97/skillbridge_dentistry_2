// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'fresh_notification_vm.dart';
//
// class FreshGraduatedNotificationDetailScreen extends StatelessWidget {
//   static const String routeName = 'freshNotificationDetails';
//
//   const FreshGraduatedNotificationDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final response =
//         context.read<FreshGraduatedNotificationCubit>().selectedResponse;
//
//     if (response == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text("Response Details")),
//         body: const Center(child: Text("No response selected.")),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Consultant Details",
//           style: GoogleFonts.inter(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: NetworkImage(response.consultantPhoto),
//                     onBackgroundImageError:
//                         (_, __) => const Icon(Icons.person, size: 40),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     response.consultantName,
//                     style: GoogleFonts.inter(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "⭐ ${response.rate.toStringAsFixed(1)}",
//                     style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
//                   ),
//                   const Divider(height: 30, thickness: 1),
//                   _buildSection("Biography", response.biography),
//                   const SizedBox(height: 16),
//                   _buildSection("Diagnosis", response.diagnosis),
//                   const SizedBox(height: 16),
//                   _buildSection("Treatment", response.treatment),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection(String title, String content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.inter(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.blueGrey[700],
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(content, style: GoogleFonts.inter(fontSize: 15)),
//       ],
//     );
//   }
// }
