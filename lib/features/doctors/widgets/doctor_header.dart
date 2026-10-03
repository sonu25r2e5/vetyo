// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vetyo/constants/app_colors.dart';
// import 'package:vetyo/constants/app_fonts.dart';
// import 'package:vetyo/core/extention/color_extention.dart';
// import 'package:vetyo/core/typography/font_style_extensions.dart';
// import 'package:vetyo/core/typography/font_style_extentions.dart';

// class DoctorHeader extends StatelessWidget {
//   final String doctorName;
//   final String greeting;
//   final String? avatarUrl;
//   final VoidCallback? onNotificationTap;

//   const DoctorHeader({
//     super.key,
//     required this.doctorName,
//     required this.greeting,
//     this.avatarUrl,
//     this.onNotificationTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Avatar with online indicator
//         Stack(
//           children: [
//             CircleAvatar(
//               radius: 21.r,
//               backgroundColor: ColorPalete.neutral.shade300,
//               backgroundImage:
//                   avatarUrl != null
//                       ? (avatarUrl!.startsWith('http')
//                           ? NetworkImage(avatarUrl!) as ImageProvider
//                           : AssetImage(avatarUrl!))
//                       : null,
//               child: avatarUrl == null ? Icon(Icons.person, size: 24.sp) : null,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: Container(
//                 width: 14.w,
//                 height: 14.w,
//                 decoration: BoxDecoration(
//                   color: ColorPalete.healingGreen.shade500,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: 20.w),

//         // Doctor info
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 doctorName,
//                 style: context.textBlackStyle().extraLarge.semiBold.withSatoshi,
//               ),
//               Text(
//                 greeting,
//                 style: TextStyle(
//                   fontSize: 10.sp,
//                   color: ColorPalete.neutral.shade400,
//                   fontFamily: AppFonts.satoshi,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         GestureDetector(
//           onTap: onNotificationTap,
//           child: Icon(Icons.notifications_outlined, size: 24.sp),
//         ),
//       ],
//     );
//   }
// }
