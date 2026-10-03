import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/appointments/screens/follow_up_enquiry_screen.dart';
import 'package:vetyo/features/appointments/screens/priority_screen.dart';
import 'package:vetyo/features/appointments/widgets/segmented_caraousel.dart';

class FollowUpFlowScreen extends StatefulWidget {
  final int initialPage;
  const FollowUpFlowScreen({super.key, this.initialPage = 0});

  @override
  State<FollowUpFlowScreen> createState() => _FollowUpFlowScreenState();
}

class _FollowUpFlowScreenState extends State<FollowUpFlowScreen> {
  late final PageController _controller;
  late int _currentIndex;

  static const int _totalPages = 2;
  final Map<String, dynamic> _appointmentData = {};

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

  bool _isEmptyValue(dynamic value) {
    if (value == null) return true;
    if (value is String) return value.trim().isEmpty;
    if (value is Iterable) return value.isEmpty;
    if (value is Map) return value.isEmpty;
    return false;
  }

  bool _validateStep(int index) {
    switch (index) {
      case 0:
        return !_isEmptyValue(_appointmentData['enquiry']);
      case 1:
        return !_isEmptyValue(_appointmentData['priority']);
      default:
        return false;
    }
  }

  String _stepValidationMessage(int index) {
    switch (index) {
      case 0:
        return 'Please complete enquiry details to continue.';
      case 1:
        return 'Please select priority to continue.';
      default:
        return 'Please complete this step to continue.';
    }
  }

  void _handleContinue() {
    if (!_validateStep(_currentIndex)) {
      showSnackBar(context, _stepValidationMessage(_currentIndex));
      return;
    }

    final bool isLastStep = _currentIndex == _totalPages - 1;

    if (!isLastStep) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      RoutePaths.bookAppointment,
      arguments: _appointmentData,
    );
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
                  "Follow Up",
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
                  final int previousIndex = _currentIndex;

                  if (index > previousIndex && !_validateStep(previousIndex)) {
                    showSnackBar(
                      context,
                      _stepValidationMessage(previousIndex),
                    );
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _controller.animateToPage(
                        previousIndex,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                      );
                    });
                    return;
                  }

                  setState(() => _currentIndex = index);
                },
                children: [
                  FollowUpScreen(
                    onContinue: (data) {
                      setState(() {
                        _appointmentData['enquiry'] = data;
                      });
                    },
                  ),
                  PriorityScreen(
                    onContinue: (data) {
                      setState(() {
                        _appointmentData['priority'] = data;
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                label: "Continue",
                onPressed: _handleContinue,
                // width: 327.w,
                height: 40.h,
                color: const Color(0xFF1DC7F2),
                labelStyle:
                    context.textBlackStyle().large.semiBold.white.withSatoshi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
