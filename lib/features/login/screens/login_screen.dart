import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/key_string.dart';
import 'package:vetyo/core/common/custom_button/custom_button.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:vetyo/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:vetyo/core/common/loading_overlay/loading_overlay.dart';
import 'package:vetyo/core/common/show_dialog/show_dialog.dart';
import 'package:vetyo/core/common/snackbar/snackbar.dart';
import 'package:vetyo/core/extention/color_extention.dart';
import 'package:vetyo/core/localization/app_translations.dart';
import 'package:vetyo/core/routes/route_helpers.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/typography/font_style_extentions.dart';
import 'package:vetyo/core/utils/shared_pref.dart';
import 'package:vetyo/features/login/bloc/login_bloc.dart';
import 'package:vetyo/features/login/widgets/background_with_image_widget.dart';
import 'package:vetyo/features/login/widgets/login_footer_view.dart';
import 'package:vetyo/features/otp_verification/bloc/otp_verification_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  bool isRemember = false;
  String savedEmail = '';
  List<CustomFormFieldConfig> formFields = [];
  bool canPop = true;

  @override
  void initState() {
    // Only get SharedPreferences data here, not localization-dependent data
    isRemember = SharedPref.getBoolValue(KeyString.loginRemember.name);
    if (isRemember) {
      savedEmail = SharedPref.getStringValue(KeyString.userEmail.name);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Now we can safely use context.l10n
    formFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.email,
        id: "username",
        label: context.l10n.emailAddress,
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.confirmPassword,
        id: "password",
        label: context.l10n.password,
        isRequired: true,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          _loadingOverlay.hide();
          RouteHelpers.pushRemoveRoute(context, RoutePaths.homeScreen);
        } else if (state is UserLoginErrorState) {
          _loadingOverlay.hide();
          ShowDialog(context: context).showErrorStateDialog(
            body: state.errorModel.message.toString(),
            onTab:
                state.errorModel.code == 403
                    ? () {
                      BlocProvider.of<OtpVerificationBloc>(
                        context,
                      ).add(SendOtpEvent(email: formData['username']));
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RoutePaths.oTPVerificationScreen,
                        arguments: {"email": formData['username']},
                      );
                    }
                    : null,
          );
        }
      },
      child: PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (bool value, dynamic val) {
          setState(() {
            FocusScope.of(context).unfocus();
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
              padding: EdgeInsets.only(top: 25.h),
              child: buildSilverAppBar(),
            ),
          ),
        ),
      ),
    );
  }

  /// Static layout like signup: fixed header image, scrollable login form area
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
        Expanded(child: buildLoginFormField()),
      ],
    );
  }

  Container buildLoginFormField() {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 28, left: 28, right: 28),
        child: ListView(
          // Only the form content is scrollable
          physics: const BouncingScrollPhysics(),
          children: [
            // Text(
            //   AppTranslations.greeting(context),
            //   textAlign: TextAlign.center,
            //   style:
            //       context
            //           .textStyle(palette: ColorPalete.zinc, swatch: 900)
            //           .header4,
            // ),
            Text(
              context.l10n.loginToYourAccount,
              textAlign: TextAlign.center,
              style: context.textBlackStyle().bold.header4,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.signInExperience,
              textAlign: TextAlign.center,
              style: context.textBlackStyle().medium.bold,
            ),
            SizedBox(height: 24.h),
            CustomFormFieldGenerator(
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
              formKey: _formKey,
              updateData: {'username': savedEmail},
              formFields: formFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    isRemember = !isRemember;
                    SharedPref.setBoolValue(
                      KeyString.loginRemember.name,
                      isRemember,
                    );
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      isRemember
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
                      const SizedBox(width: 5),
                      Text(
                        context.l10n.rememberMe,
                        style:
                            context
                                .textStyle(
                                  palette: ColorPalete.neutral,
                                  swatch: 800,
                                )
                                .xsmall
                                .regular,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        right: 8,
                        left: 8,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.resetPasswordEmailScreen,
                    );
                  },
                  child: Text(
                    context.l10n.forgotPassword,
                    style: context
                        .textStyle(palette: ColorPalete.brand, swatch: 500)
                        .small
                        .regular
                        .copyWith(decorationThickness: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              gradient: LinearGradient(
                colors: [AppColor.brightSkyMain, AppColor.healingGreenMain],
              ),
              height: 55,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // _loadingOverlay.show(context);
                  Navigator.pushNamed(context, "/homeScreen");
                  // Navigator.pushNamed(context, "/doctorHomeScreen");

                  final email = formData['username'] ?? '';
                  final password = formData['password'] ?? '';

                  // Simple check for empty fields
                  if (email.isEmpty || password.isEmpty) {
                    showSnackBar(context, context.l10n.emptyFieldError);
                    return;
                  }

                  // Regex to detect doctor or user
                  final doctorRegex = RegExp(r'doctor', caseSensitive: false);
                  final userRegex = RegExp(r'user', caseSensitive: false);

                  if (doctorRegex.hasMatch(email)) {
                    // Navigate to doctor page
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePaths
                          .doctorHomeScreen, // replace with your doctor page
                    );
                  } else if (userRegex.hasMatch(email)) {
                    // Navigate to user page
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePaths.homeScreen, // replace with your user page
                    );
                  } else {
                    // Invalid email pattern
                    showSnackBar(context, context.l10n.invalidEmailFormatError);
                  }
                }
              },
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              color: context.applyAppColor(
                palette: ColorPalete.brand,
                swatch: 300,
              ),
              buttonPadding: EdgeInsets.zero,
              label: context.l10n.login,
            ),
            const SizedBox(height: 16),
            const AuthenticateFooterView(routePath: 'loginScreen'),
          ],
        ),
      ),
    );
  }
}
