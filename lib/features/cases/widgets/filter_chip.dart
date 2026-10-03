// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vetyo/constants/app_colors.dart';

// class FilterChip extends StatefulWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const FilterChip({
//     super.key,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   State<FilterChip> createState() => _FilterChipState();
// }

// class _FilterChipState extends State<FilterChip> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color:
//                 widget.isSelected
//                     ? ColorPalete.brightSky.shade500
//                     : const Color(0xFF939393),
//             width: 1,
//           ),
//           color:
//               widget.isSelected
//                   ? AppColor.brightSkyMain
//                   : ColorPalete.oceanTeal[50],
//         ),
//         child: Text(
//           widget.label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color:
//                 widget.isSelected
//                     ? ColorPalete.brightSky.shade500
//                     : const Color(0xFF6f7070),
//             fontFamily: 'Satoshi',
//             letterSpacing: 0,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FilterChipsRow extends StatefulWidget {
//   final List<String> labels;
//   final int selectedIndex;
//   final Function(int) onChipSelected;

//   const FilterChipsRow({
//     super.key,
//     required this.labels,
//     required this.selectedIndex,
//     required this.onChipSelected,
//   });

//   @override
//   State<FilterChipsRow> createState() => _FilterChipsRowState();
// }

// class _FilterChipsRowState extends State<FilterChipsRow> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           widget.labels.length,
//           (index) => Padding(
//             padding: EdgeInsets.symmetric(horizontal: 6.w),
//             child: FilterChip(
//               label: widget.labels[index],
//               isSelected: widget.selectedIndex == index,
//               onTap: () {
//                 widget.onChipSelected(index);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
