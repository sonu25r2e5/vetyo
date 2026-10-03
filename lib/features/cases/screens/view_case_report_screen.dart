import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/cases/model/mock_case_data.dart';
import 'package:vetyo/features/cases/widgets/case_report_card.dart';

class ViewCaseReportScreen extends StatefulWidget {
  const ViewCaseReportScreen({super.key});

  @override
  State<ViewCaseReportScreen> createState() => _ViewCaseReportScreenState();
}

class _ViewCaseReportScreenState extends State<ViewCaseReportScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showBackButton: true,
      bodyColor: AppColor.whiteColor,
      title: Text('Report Case', style: context.textBlackStyle().header6),
      trailing: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Current Report Section - Using mock data
            CaseReportCard(
              caseReport: mockActiveCaseBird,
              onTap: () {
                // Navigate to details
              },
              appointmentStatus: 'Scheduled',
              totalPaid: 'Rs.1000',
            ),
          ],
        ),
      ),
    );
  }
}
