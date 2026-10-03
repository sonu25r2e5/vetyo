// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vetyo/core/common/base_page/base_page.dart';
// import 'package:vetyo/features/cases/widgets/case_report_card.dart';
// import 'package:vetyo/features/cases/screens/report_case.dart';

// class AllCaseReportsScreen extends StatelessWidget {
//   const AllCaseReportsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       showBackButton: true,
//       bodyColor: const Color(0xFFEAE6E6),
//       title: Text(
//         'All Case Reports',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.w500,
//           color: Colors.black,
//           fontFamily: "Satoshi",
//         ),
//       ),
//       body: ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//         itemCount: _dummyCaseReports.length,
//         separatorBuilder: (context, index) => SizedBox(height: 16.h),
//         itemBuilder: (context, index) {
//           final report = _dummyCaseReports[index];
//           return CaseReportCard(
//             statusText: report['status']!,
//             statusColor: _getStatusColor(report['status']!),
//             statusIcon: _getStatusIcon(report['status']!),
//             patientName: report['patientName']!,
//             breed: report['breed']!,
//             age: report['age']!,
//             category: report['category']!,
//             specificPatient: report['specificPatient']!,
//             consultationType: report['consultationType']!,
//             consultationColor: _getConsultationColor(
//               report['consultationType']!,
//             ),
//             consultationIcon: _getConsultationIcon(report['consultationType']!),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ClosedCaseReport(),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return const Color(0xFF08AC84);
//       case 'closed':
//         return const Color(0xFFDE1515);
//       case 'pending':
//         return const Color(0xFFFF9800);
//       default:
//         return const Color(0xFF08AC84);
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return Icons.check_circle;
//       case 'closed':
//         return Icons.cancel;
//       case 'pending':
//         return Icons.access_time;
//       default:
//         return Icons.check_circle;
//     }
//   }

//   Color _getConsultationColor(String type) {
//     switch (type.toLowerCase()) {
//       case 'high priority':
//         return const Color(0xFFDE1515);
//       case 'medium priority':
//         return const Color(0xFFFF9800);
//       case 'low priority':
//         return const Color(0xFF08AC84);
//       default:
//         return const Color(0xFFDE1515);
//     }
//   }

//   IconData _getConsultationIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'high priority':
//         return Icons.star;
//       case 'medium priority':
//         return Icons.star_half;
//       case 'low priority':
//         return Icons.star_outline;
//       default:
//         return Icons.star;
//     }
//   }
// }

// // Dummy data for case reports
// final List<Map<String, String>> _dummyCaseReports = [
//   {
//     'status': 'Active',
//     'category': 'Pet',
//     'specificPatient': 'Dog',
//     'patientName': 'Bruno',
//     'breed': 'Poodle',
//     'age': '6 months',
//     'consultationType': 'High Priority',
//   },
//   {
//     'status': 'Closed',
//     'category': 'Pet',
//     'specificPatient': 'Cat',
//     'patientName': 'Whiskers',
//     'breed': 'Persian',
//     'age': '2 years',
//     'consultationType': 'Medium Priority',
//   },
//   {
//     'status': 'Pending',
//     'category': 'Pet',
//     'specificPatient': 'Dog',
//     'patientName': 'Max',
//     'breed': 'Golden Retriever',
//     'age': '3 years',
//     'consultationType': 'Low Priority',
//   },
//   {
//     'status': 'Active',
//     'category': 'Farm',
//     'specificPatient': 'Cow',
//     'patientName': 'Bessie',
//     'breed': 'Holstein',
//     'age': '5 years',
//     'consultationType': 'High Priority',
//   },
//   {
//     'status': 'Closed',
//     'category': 'Pet',
//     'specificPatient': 'Dog',
//     'patientName': 'Rocky',
//     'breed': 'Bulldog',
//     'age': '4 years',
//     'consultationType': 'Medium Priority',
//   },
//   {
//     'status': 'Active',
//     'category': 'Pet',
//     'specificPatient': 'Cat',
//     'patientName': 'Luna',
//     'breed': 'Siamese',
//     'age': '1 year',
//     'consultationType': 'High Priority',
//   },
// ];
