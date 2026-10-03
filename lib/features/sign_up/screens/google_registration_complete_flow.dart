import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/helpers/dialogs.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/appointments/widgets/segmented_caraousel.dart';
import 'package:vetyo/features/sign_up/screens/input_profile_info_screen.dart';
import 'package:vetyo/features/sign_up/screens/user_upload_change_picture.dart';
import 'package:vetyo/features/sign_up/widgets/Upload_photo_widget.dart';
import 'package:vetyo/features/sign_up/widgets/success_registration_dialog.dart';

class GoogleRegistrationCompleteFlow extends StatefulWidget {
  final int initialPage;
  const GoogleRegistrationCompleteFlow({super.key, this.initialPage = 0});

  @override
  State<GoogleRegistrationCompleteFlow> createState() =>
      _GoogleRegistrationCompleteFlowState();
}

class _GoogleRegistrationCompleteFlowState
    extends State<GoogleRegistrationCompleteFlow> {
  late final PageController _controller;
  late int _currentIndex;
  File? _profileImage;

  static const int _totalPages = 2;
  final Map<String, dynamic> _registrationData = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
    _controller = PageController(initialPage: widget.initialPage);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFFAFAFA),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final bool isLastStep = _currentIndex == _totalPages - 1;

    if (!isLastStep) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }

    _registrationData['profileImage'] = _profileImage?.path;

    // Navigate to home after completing registration
    Navigator.pushReplacementNamed(
      context,
      RoutePaths.homeScreen,
      arguments: _registrationData,
    );
  }

  // File? _selectedImage;

  Future<void> _pickImage() async {
    final image = await AppImagePicker.show(
      context: context,
      title: "Upload photo ?",
    );

    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    color: AppColor.brightSkyMain,
                  ),
                ),
                Text(
                  "User Registration",
                  style: context.textBlackStyle().header6.semiBold.withSatoshi,
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: [
                  InputProfileInformationScreen(),
                  UserUploadChangePicture(
                    onImageChanged: (File? image) {
                      setState(() {
                        _profileImage = image;
                      });
                    },
                  ),
                ],
              ),
            ),
            SegmentedCarouselIndicator(
              currentIndex: _currentIndex,
              itemCount: _totalPages,
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 48.w,
                    height: 42.h,
                    child: CustomIconButton(
                      iconWidget: iconoir.ArrowLeft(
                        width: 24.w,
                        height: 24.w,
                        color: const Color(0xFF062933),
                      ),
                      onPressed:
                          _currentIndex > 0
                              ? () => _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              )
                              : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      label:
                          _currentIndex == _totalPages - 1
                              ? "Complete"
                              : "Continue",
                      onPressed: _handleContinue,
                      height: 40.h,
                      buttonPadding: EdgeInsets.zero,
                      color: const Color(0xFF1DC7F2),
                      labelStyle:
                          context
                              .textBlackStyle()
                              .large
                              .semiBold
                              .white
                              .withSatoshi,
                    ),
                  ),
                ],
              ),
            ),
            if (_currentIndex == _totalPages - 1) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: CustomTextButton(
                  label: "Skip for Now",
                  onPressed: () {
                    PlatformDialog.showDesignDialog(
                      isIconRequired: true,
                      iconWidget: iconoir.MediaImageXmark(
                        width: 30.w,
                        height: 30.w,
                        color: AppColor.successColor,
                      ),
                      context: context,
                      title: 'Skip registration',
                      content: const Text(
                        'Are you sure you want to skip registration for now?',
                      ),
                      backgroundColor: AppColor.whiteColor,
                      confirmText: 'Skip & Finish',
                      cancelText: 'Add a photo',
                    ).then((result) {
                      if (result != false) {
                        SuccessRegistrationDialog.show(
                          context,
                          title: 'Registration Complete',
                          message:
                              'Your account has been created successfully.',
                          onContinue: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutePaths.homeScreen,
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        _pickImage();
                      }
                    });
                  },
                  labelStyle:
                      context.textBlackStyle().medium.withSatoshi.brightSky950,
                ),
              ),
            ] else
              SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
