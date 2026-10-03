import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/loading_overlay/loading_overlay.dart';
import 'package:vetyo/core/common/show_dialog/show_dialog.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/color_style_extensions.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/features/login/widgets/background_with_image_widget.dart';
import 'package:vetyo/features/login/widgets/login_footer_view.dart';
import 'package:vetyo/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:vetyo/features/sign_up/bloc/signup_bloc.dart';
import 'package:vetyo/features/sign_up/screens/user_registration_flow.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];

  bool canPop = false;
  bool isVetSelected = true;
  bool agreeToTerms = false;

  String password = '';
  String confirmPassword = '';

  @override
  void initState() {
    super.initState();
    getFormField();
  }

  void getFormField() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.email,
        id: "email",
        label: "Email Address",
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.password,
        id: "password",
        label: "Password",
        isRequired: true,
        isObscure: true,
        onChanged: (value) {
          password = value;
          setState(() {});
        },
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.confirmPassword,
        id: "confirmPassword",
        label: "Confirm Password",
        isRequired: true,
        isObscure: true,
        onChanged: (value) {
          confirmPassword = value;
          setState(() {});
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupWithPasswordSuccessState) {
          _loadingOverlay.hide();

          Navigator.pushNamed(
            context,
            RoutePaths.oTPVerificationScreen,
            arguments: {"email": formData['email']},
          );
        }

        if (state is SignupWithPasswordErrorState) {
          _loadingOverlay.hide();

          ShowDialog(context: context).showErrorStateDialog(
            body: state.errorModel.message.toString(),
            onTab:
                state.errorModel.code == 403
                    ? () {
                      context.read<OtpVerificationBloc>().add(
                        SendOtpEvent(email: formData['email']),
                      );

                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        RoutePaths.oTPVerificationScreen,
                        arguments: {"email": formData['email']},
                      );
                    }
                    : null,
          );
        }
      },
      child: PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (value, result) {
          setState(() {
            canPop = !value;
          });

          if (canPop) {
            showAppExistSnackBar(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: buildSilverAppBar(),
            ),
          ),
        ),
      ),
    );
  }

  Container signUpFormField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: ListView(
          // Only the form content is scrollable
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Create Your Account",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().bold.header4,
            ),
            const SizedBox(height: 8),
            Text(
              "Sign up to access all features",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().medium.bold,
            ),
            const SizedBox(height: 18),

            CustomFormFieldGenerator(
              formKey: _formKey,
              formFields: formFields,
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
            ),

            Visibility(
              visible:
                  password.isNotEmpty &&
                  confirmPassword.isNotEmpty &&
                  password != confirmPassword,
              child: Text(
                "Password and Confirm Password must be the same.",
                style:
                    context.textStyle(palette: ColorPalete.red).xsmall.regular,
              ),
            ),

            GestureDetector(
              onTap: () {
                agreeToTerms = !agreeToTerms;
                setState(() {});
              },
              child: Row(
                children: [
                  agreeToTerms
                      ? Iconoir.CheckSquare(
                        width: 20,
                        height: 20,
                        color: context.applyAppColor(
                          palette: ColorPalete.green,
                        ),
                      )
                      : Icon(
                        Icons.square_outlined,
                        size: 20,
                        color: context.applyAppColor(
                          palette: ColorPalete.slate,
                        ),
                      ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          context.l10n.agreeToTerms + " ",
                          style:
                              context
                                  .textStyle(
                                    palette: ColorPalete.neutral,
                                    swatch: 800,
                                  )
                                  .xsmall
                                  .regular,
                        ),
                        Text(
                          context.l10n.termsAndConditions,
                          style:
                              context.textBlackStyle().small.bold.brightSky700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            CustomButton(
              height: 55,
              gradient: LinearGradient(
                colors: [AppColor.brightSkyMain, AppColor.healingGreenMain],
              ),
              label: "Sign Up",
              buttonPadding: EdgeInsets.zero,
              color: context.applyAppColor(palette: ColorPalete.brand),
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              onPressed: () {
                final isPasswordValid =
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty &&
                    password == confirmPassword;

                if (!_formKey.currentState!.validate() ||
                    !isPasswordValid ||
                    !agreeToTerms) {
                  if (!agreeToTerms) {
                    showSnackBar(
                      context,
                      "Please agree to terms and conditions",
                    );
                  }
                  return;
                }

                // Navigator.pushNamed(
                //   context,
                //   RoutePaths.inputProfileInformationScreen,
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserRegistrationFlow(),
                  ),
                );

                // final request = {
                //   "email": formData['email'],
                //   "password": password,
                // };

                // if (isVetSelected) {
                //   Navigator.pushNamed(
                //     context,
                //     RoutePaths.doctorDetailsInputScreen,
                //     arguments: {"formData": request},
                //   );
                // } else {
                //   _loadingOverlay.show(context);

                //   context.read<SignupBloc>().add(
                //     SignupWithPassword(formData: request),
                //   );
                // }
              },
            ),

            const SizedBox(height: 16),

            const AuthenticateFooterView(routePath: ""),
          ],
        ),
      ),
    );
  }

  /// Static layout: fixed header image, scrollable signup form area
  Widget buildSilverAppBar() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 175.h,
          width: double.infinity,
          child: const Hero(tag: "toolbar", child: BackgroundWithImageWidget()),
        ),
        // Form area fills remaining space and can scroll internally
        Expanded(child: signUpFormField(context)),
      ],
    );
  }
}
