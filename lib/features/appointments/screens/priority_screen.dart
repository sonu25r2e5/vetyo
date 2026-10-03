import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class PriorityScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onContinue;
  final VoidCallback? onBack;

  const PriorityScreen({super.key, this.onContinue, this.onBack});

  @override
  State<PriorityScreen> createState() => _PriorityScreenState();
}

class _PriorityScreenState extends State<PriorityScreen> {
  String? selectedPriority;

  final List<Map<String, dynamic>> priorities = [
    {
      'title': 'High priority',
      'subtitle': 'Immediate action needed',
      'icon': Icons.warning,
      'iconColor': Color(0xFFFF0000),
      'value': 'high',
    },
    {
      'title': 'Normal Priority',
      'subtitle': 'No immediate danger',
      'icon': Icons.error_outline,
      'iconColor': Color(0xFFFFA500),
      'value': 'normal',
    },
    {
      'title': 'Low Priority',
      'subtitle': 'General Guidance',
      'icon': Icons.arrow_downward,
      'iconColor': Color(0xFF00C853),
      'value': 'low',
    },
  ];

  /// Gather priority data and notify parent
  void gatherAndNotifyPriority() {
    final priorityData = {'priority': selectedPriority};

    if (widget.onContinue != null) {
      widget.onContinue!(priorityData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  // Title and Subtitle
                  SizedBox(
                    width: 331.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Select Medication Priority',
                          style:
                              context
                                  .textBlackStyle()
                                  .semiBold
                                  .large
                                  .withSatoshi,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Choose how urgent your pet\'s condition is',
                          style:
                              context
                                  .textBlackStyle()
                                  .medium
                                  .withSatoshi
                                  .slate500,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 55.h),

                  // Priority Options
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: priorities.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 25.h),
                    itemBuilder: (context, index) {
                      final priority = priorities[index];
                      final isSelected = selectedPriority == priority['value'];
                      return _buildPriorityCard(
                        title: priority['title'],
                        subtitle: priority['subtitle'],
                        icon: priority['icon'],
                        iconColor: priority['iconColor'],
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedPriority = priority['value'];
                          });
                          // Notify parent when priority is selected
                          gatherAndNotifyPriority();
                        },
                      );
                    },
                  ),

                  SizedBox(height: 180.h),
                ],
              ),
            ),
          ),
        ),

        // Progress Bar and Continue Button (Fixed at bottom)
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 24.w),
        //   child: Column(
        //     children: [
        //       _buildProgressBar(),
        //       SizedBox(height: 12.h),
        //       GestureDetector(
        //         onTap: () {
        //           // Validate priority is selected
        //           if (selectedPriority == null) {
        //             ScaffoldMessenger.of(context).showSnackBar(
        //               SnackBar(
        //                 content: Text(
        //                   'Please select a priority level',
        //                   style: TextStyle(fontFamily: "Satoshi"),
        //                 ),
        //                 backgroundColor: Colors.red,
        //               ),
        //             );
        //             return;
        //           }

        //           // Call the callback or navigate
        //           if (widget.onContinue != null) {
        //             widget.onContinue!({'priority': selectedPriority});
        //           }
        //         },
        //         child: Container(
        //           width: double.infinity,
        //           height: 48.h,
        //           decoration: BoxDecoration(
        //             color: const Color(0xFF1DC7F2),
        //             borderRadius: BorderRadius.circular(20.r),
        //           ),
        //           alignment: Alignment.center,
        //           child: Text(
        //             'Continue',
        //             style: TextStyle(
        //               fontSize: 16.sp,
        //               fontWeight: FontWeight.w700,
        //               color: Colors.white,
        //               fontFamily: "Satoshi",
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildPriorityCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF56F6CF) : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: const Color(0xFF29C5A2).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: const Color(0xFF29C5A2).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(icon, size: 20.w, color: iconColor),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: "Satoshi",
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF404040),
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
