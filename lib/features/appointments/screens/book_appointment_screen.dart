import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Sample data - replace with actual data
  final Map<String, String> appointmentDetails = {
    'vet': 'Dr. Sarah Johnson',
    'issue': 'Skin Infection',
    'consultationType': 'Video Call',
    'dateTime': 'Jan 28, 2026 - 10:00 AM',
    'fee': '\$50',
  };

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.w,
                      color: const Color(0xFF404040),
                    ),
                  ),
                  Text(
                    'Book Appointment',
                    style: context.textBlackStyle().semiBold.large.withSatoshi,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Save draft functionality
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RoutePaths.homeScreen,
                        arguments: 2, // Cases tab index
                      );
                    },
                    child: Text(
                      'Save Draft',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF146251),
                        fontFamily: "Satoshi",
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.h),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    // Title
                    Text(
                      'Confirm appointment Details',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0A3128),
                        fontFamily: "Satoshi",
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Appointment Details Card
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(4.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        children: [
                          _buildDetailRow('Vet', appointmentDetails['vet']!),
                          SizedBox(height: 10.h),
                          _buildDetailRow(
                            'Issue',
                            appointmentDetails['issue']!,
                          ),
                          SizedBox(height: 10.h),
                          _buildDetailRow(
                            'Consultation Type',
                            appointmentDetails['consultationType']!,
                          ),
                          SizedBox(height: 10.h),
                          _buildDetailRow(
                            'Date & Time',
                            appointmentDetails['dateTime']!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Fee Card
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(4.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Consultation Fee',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                  fontFamily: "Satoshi",
                                ),
                              ),
                              Text(
                                appointmentDetails['fee']!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0A0A0A),
                                  fontFamily: "Satoshi",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '30 minute session',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF525252),
                              fontFamily: "Satoshi",
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 300.h),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              color: const Color(0xFFFAFAFA),
              child: Column(
                children: [
                  // Confirm & Pay Button
                  GestureDetector(
                    onTap: () {
                      // Navigate to payment screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Proceeding to payment...',
                            style: TextStyle(fontFamily: "Satoshi"),
                          ),
                          backgroundColor: const Color(0xFF1DC7F2),
                        ),
                      );

                      Navigator.pushNamed(
                        context,
                        RoutePaths.appoinmentPaymentScreen,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1DC7F2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Confirm & Pay',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: "Satoshi",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Edit Appointment Details Button
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 16.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStepIndicator(String label, bool isCompleted, bool isLastStep) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 3.h,
  //         decoration: BoxDecoration(
  //           color:
  //               isCompleted ? const Color(0xFF34F4C6) : const Color(0xFFD4D4D4),
  //           borderRadius: BorderRadius.circular(4.r),
  //         ),
  //         margin: EdgeInsets.only(right: isLastStep ? 0 : 10.w),
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 12.sp,
  //           fontWeight: FontWeight.w500,
  //           color: const Color(0xFF404040),
  //           fontFamily: label == 'Select Vet' ? "Satoshi" : "Inter",
  //         ),
  //         textAlign: TextAlign.center,
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF404040),
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0A0A0A),
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }
}
