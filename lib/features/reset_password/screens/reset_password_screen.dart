import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/base_page/base_page.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/loading_overlay/loading_overlay.dart';
import 'package:vetyo/core/common/show_dialog/show_dialog.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/reset_password/bloc/reset_password_bloc.dart';
import 'package:vetyo/features/reset_password/widgets/reset_password_alert_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? otpNumber;
  final String? email;
  const ResetPasswordScreen({super.key, required this.otpNumber, this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPassordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          _loadingOverlay.hide();
          Navigator.pushNamed(context, RoutePaths.resetPasswordSuccessScreen);
        } else if (state is ResetPasswordErrorState) {
          _loadingOverlay.hide();
          ShowDialog(
            context: context,
          ).showErrorStateDialog(body: state.errorModel.message.toString());
        }
      },
      child: PopScope(
        canPop: false,
        child: BasePage(
          elevation: 0,
          showAppBar: true,
          // backgroundColor: AppColor.whiteColor,
          title: Text(
            'Reset Password',
            style: context.textBlackStyle().header6.bold.withBaloo2.copyWith(
              color: ColorPalete.oceanTeal.shade900,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your new password must be different from your\n previous password",
                            style: context
                                .textBlackStyle()
                                .medium
                                .fontWeightMedium
                                .withSatoshi
                                .copyWith(
                                  color: ColorPalete.oceanTeal.shade200,
                                ),
                          ),
                          SizedBox(height: 32.h),
                          CustomFormField(
                            config: CustomFormFieldConfig(
                              fieldType: FieldType.password,
                              id: "oldPassword",
                              controller: oldPassordController,
                              label: "Confirm Old Password",
                              isRequired: true,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            config: CustomFormFieldConfig(
                              fieldType: FieldType.password,
                              id: "newPassword",
                              controller: newPasswordController,
                              label: "New Password",
                              isRequired: true,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          CustomFormField(
                            config: CustomFormFieldConfig(
                              fieldType: FieldType.password,
                              id: "confirmPassword",
                              controller: confirmPasswordController,
                              label: "Confirm Password",
                              isRequired: true,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Both passwords must match",
                            style: context
                                .textBlackStyle()
                                .medium
                                .fontWeightMedium
                                .withSatoshi
                                .copyWith(
                                  color: ColorPalete.oceanTeal.shade200,
                                ),
                          ),
                          const SizedBox(height: 40),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  newPasswordController.text ==
                                      confirmPasswordController.text) {
                                _formKey.currentState!.save();
                                Map<String, dynamic> formData = {
                                  'oneTimePass': widget.otpNumber,
                                  "newPassword": newPasswordController.text,
                                  'email': widget.email,
                                };

                                showConfirmationDialog(context, formData);
                              }
                            },
                            height: 55,
                            labelStyle:
                                context
                                    .textBlackStyle()
                                    .medium
                                    .fontWeightMedium
                                    .withSatoshi
                                    .brightSky50,
                            color: AppColor.brightSkyMain,
                            buttonPadding: EdgeInsets.zero,
                            label: "Update Password",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
