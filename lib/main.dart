import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vetyo/constants/api_urls.dart';
import 'package:vetyo/core/config/themes.dart';
import 'package:vetyo/core/di/injector.dart';
import 'package:vetyo/core/language/cubit/language_cubit.dart';
import 'package:vetyo/core/language/l10n.dart';
import 'package:vetyo/generated/l10n/app_localizations.dart';
import 'package:vetyo/core/navigation_service/navigation_service.dart';
import 'package:vetyo/core/routes/route_handler.dart';
import 'package:vetyo/core/splash/splash_screen.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

import 'package:vetyo/features/login/bloc/login_bloc.dart';

import 'package:vetyo/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:vetyo/features/otp_verification/cubit/resend_timer_cubit.dart';
import 'package:vetyo/features/profile/bloc/profile_bloc.dart';
import 'package:vetyo/features/reset_password/bloc/reset_password_bloc.dart';
import 'package:vetyo/features/sign_up/bloc/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ChuckerFlutter.showNotification = true;
  await SharedPref.initializeSharedPreference();
  await setUpDi(ApiUrls.devBaseUrl);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) {
            final cubit = LanguageCubit();
            cubit.initializeLanguage(); // Initialize saved language preference
            return cubit;
          },
        ),

        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(),
        ),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<ResetPasswordBloc>(
          create: (BuildContext context) => ResetPasswordBloc(),
        ),
        BlocProvider<ResendTimerCubit>(
          create: (BuildContext context) => ResendTimerCubit(),
        ),
        BlocProvider<OtpVerificationBloc>(
          create: (BuildContext context) => OtpVerificationBloc(),
        ),

        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: DevicePreview.appBuilder,
                navigatorObservers: [ChuckerFlutter.navigatorObserver],
                title: 'Vetyo',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: L10n.all,
                locale: state,
                theme: AppThemes.lightTheme,
                initialRoute: '/',
                onGenerateRoute: RouteHandler.generateRoute,
                navigatorKey: NavigationService.navigatorKey,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
