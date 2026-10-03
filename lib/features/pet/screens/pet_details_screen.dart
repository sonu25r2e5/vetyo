import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';

class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({super.key});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Text(
        "Review Summary",
        style:
            context
                .textStyle(palette: ColorPalete.supporting2, swatch: 700)
                .large
                .semiBold,
      ),
      showBackButton: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPetProfileSection(),
            SizedBox(height: 32.h),
            _buildAttachmentSection(),
            SizedBox(height: 32.h),
            _buildAppointmentDetailsSection(),
            SizedBox(height: 32.h),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPetProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Pet Profile",
            style:
                context
                    .textStyle(palette: ColorPalete.supporting2, swatch: 700)
                    .large
                    .bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFF5F5F5), width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              // Pet Avatar
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD9D9D9),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.avatarImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pet name and type
                    Text(
                      "Burno (Terrier)",
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.healingGreen,
                                swatch: 950,
                              )
                              .medium
                              .medium,
                    ),
                    SizedBox(height: 4.h),
                    // Pet breed with icon
                    Row(
                      children: [
                        iconoir.Wolf(
                          width: 16.8.w,
                          height: 16.8.w,
                          color: context.applyAppColor(
                            palette: ColorPalete.supporting2,
                            swatch: 600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "German Sheperd",
                          style:
                              context
                                  .textStyle(
                                    palette: ColorPalete.supporting2,
                                    swatch: 600,
                                  )
                                  .small
                                  .regular,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Age button
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.applyAppColor(
                          palette: ColorPalete.brightSky,
                          swatch: 100,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "3 Years",
                          style:
                              context
                                  .textStyle(
                                    palette: ColorPalete.brightSky,
                                    swatch: 950,
                                  )
                                  .medium
                                  .medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentSection() {
    return Container(
      width: double.infinity,
      height: 189.h,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: ColorPalete.brightSky[100]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorPalete.healingGreen[500]!, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Attachment",
                style:
                    context
                        .textStyle(palette: ColorPalete.supporting2)
                        .large
                        .bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Text(
                "Enter your pet's document, prescriptions and\nattachments",
                style:
                    context
                        .textStyle(palette: ColorPalete.supporting2)
                        .medium
                        .regular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 13.h),
              // Upload section
              Container(
                width: 104.w,
                height: 68.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPalete.healingGreen[950]!,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: iconoir.MediaImagePlus(
                    width: 24.w,
                    height: 24.w,
                    color: context.applyAppColor(
                      palette: ColorPalete.healingGreen,
                      swatch: 950,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Appointment Details",
          style:
              context
                  .textStyle(palette: ColorPalete.supporting2, swatch: 700)
                  .large
                  .bold,
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFF5F5F5), width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDoctorCard("Dr.Ramlal Yadav", "Senior cardiologist"),
              SizedBox(height: 12.h),
              _buildDoctorCard("Dr.Ramlal Yadav", "Senior cardiologist"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorCard(String doctorName, String specialty) {
    return Row(
      children: [
        // Doctor Avatar with online status
        Stack(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9),
                image: const DecorationImage(
                  image: AssetImage(AppImages.avatarImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: ColorPalete.healingGreen[500]!,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorName,
                style:
                    context
                        .textStyle(
                          palette: ColorPalete.healingGreen,
                          swatch: 950,
                        )
                        .medium
                        .medium,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  iconoir.Healthcare(
                    width: 16.8.w,
                    height: 16.8.w,
                    color: context.applyAppColor(
                      palette: ColorPalete.supporting2,
                      swatch: 600,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    specialty,
                    style:
                        context
                            .textStyle(
                              palette: ColorPalete.supporting2,
                              swatch: 600,
                            )
                            .small
                            .regular,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Calendar icon button
        GestureDetector(
          onTap: () {
            // Handle calendar tap
          },
          child: Container(
            padding: EdgeInsets.all(6.w),
            child: iconoir.CalendarMinus(
              width: 24.w,
              height: 24.w,
              color: context.applyAppColor(
                palette: ColorPalete.supporting2,
                swatch: 700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: CustomButton(
        label: "Continue",
        onPressed: () {
          // Handle continue action
        },
        color: ColorPalete.brightSky[500]!,
        labelStyle:
            context.textStyle(palette: ColorPalete.white).medium.semiBold,
        height: 42.h,
      ),
    );
  }
}
