import 'package:flutter/material.dart';
import 'package:vetyo/constants/key_string.dart';
import 'package:vetyo/core/common/show_dialog/show_dialog.dart';
import 'package:vetyo/core/routes/route_helpers.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get currentContext => navigatorKey.currentState?.context;

  static routeToLogin() {
    RouteHelpers.pushRemoveRoute(
      navigatorKey.currentState?.context,
      RoutePaths.loginScreen,
    );
  }

  static logOutUser() async {
    await SharedPref.deleteData(KeyString.authTokenKey.name);
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    ShowDialog(
      context: navigatorKey.currentState!.context,
    ).showErrorStateDialog(
      title: "Session Expired",
      body: "Please log in again",
      onTab: () {
        RouteHelpers.pushRemoveRoute(
          navigatorKey.currentState?.context,
          RoutePaths.loginScreen,
        );
      },
    );
    // });
  }
}
