import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetyo/constants/app_colors.dart';
import 'package:vetyo/constants/app_images.dart';
import 'package:vetyo/constants/key_string.dart';
import 'package:vetyo/core/routes/route_helpers.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      String token = SharedPref.getStringValue(KeyString.authTokenKey.name);
      bool isOnboard = SharedPref.getBoolValue(KeyString.onboardUser.name);
      bool isLoginUser = SharedPref.getBoolValue(KeyString.isLoginUser.name);
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      if (token.isNotEmpty && isLoginUser) {
        RouteHelpers.pushRemoveRoute(context, RoutePaths.loginScreen);
      } else if (isOnboard) {
        RouteHelpers.pushRemoveRoute(context, RoutePaths.loginScreen);
      } else {
        RouteHelpers.pushRemoveRoute(context, RoutePaths.initialScreen);
      }
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColor.whiteColor),
        child: Center(
          child: Image.asset(AppImages.appImage, width: 195, height: 212),
        ),
      ),
    );
  }
}
