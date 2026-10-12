import 'package:flutter/material.dart';
import 'package:vetyo/core/common/custom_listview/custom_search_listview.dart';
import 'package:vetyo/core/common/error_page/error_page.dart';
import 'package:vetyo/core/routes/route_paths.dart';
import 'package:vetyo/features/appointments/screens/appoinment_payment_screen.dart';
import 'package:vetyo/features/appointments/screens/appointment_list_screen.dart';
import 'package:vetyo/features/appointments/screens/book_appointment_screen.dart';
import 'package:vetyo/features/appointments/screens/book_apppointment_flow.dart';
import 'package:vetyo/features/appointments/screens/follow_up_flow.dart';
import 'package:vetyo/features/aqua/screens/add_aqua_screens.dart';
import 'package:vetyo/features/cases/screens/closed_case_report.dart';
import 'package:vetyo/features/cases/screens/cases_media_screen.dart';
import 'package:vetyo/features/cases/screens/user_cases_screen.dart';
import 'package:vetyo/features/cases/screens/view_case_report_screen.dart';
import 'package:vetyo/features/category_profile/screens/category_profile_details_screen.dart';
import 'package:vetyo/features/community/screens/add_poll_screen.dart';
import 'package:vetyo/features/community/screens/add_post_screen.dart';
import 'package:vetyo/features/community/screens/community_page.dart';
import 'package:vetyo/features/community/screens/post_details_screen.dart';
import 'package:vetyo/features/community/widgets/share_post_card_widget.dart';
import 'package:vetyo/features/doctor_chat_case/screens/doctor_case_chat_screen.dart';
import 'package:vetyo/features/doctor_chat_case/screens/case_picture_screen.dart';
import 'package:vetyo/features/doctors/screens/doctor_home_page.dart';
import 'package:vetyo/features/doctors/screens/doctor_profile_details_screen.dart';
import 'package:vetyo/features/doctors/screens/edit_doctor_profile_screen.dart';
import 'package:vetyo/features/home/home_page.dart';
import 'package:vetyo/features/home/screens/article_search_screen.dart';
import 'package:vetyo/features/livestocks/screens/add_livestock_screen.dart';
import 'package:vetyo/features/poultry/screens/add_poultry_screen.dart';
import 'package:vetyo/features/login/screens/login_screen.dart';
import 'package:vetyo/features/notification/screens/notification_screen.dart';
import 'package:vetyo/features/onboarding/screens/initial_screen.dart';
import 'package:vetyo/features/onboarding/screens/onboarding_screen.dart';
import 'package:vetyo/features/otp_verification/screens/otp_verification.dart';
import 'package:vetyo/features/otp_verification/screens/otp_verify_success_screen.dart';
import 'package:vetyo/features/pet/screens/add_pet_screens.dart';
import 'package:vetyo/features/profile/screens/Favorite_screen.dart';
import 'package:vetyo/features/profile/screens/category_profile_screen.dart';
import 'package:vetyo/features/profile/screens/edit_profile_screen.dart';
import 'package:vetyo/features/profile/screens/add_register_profile_screen.dart';
import 'package:vetyo/features/profile/screens/language_screen.dart';
import 'package:vetyo/features/profile/screens/setting_screen.dart';
import 'package:vetyo/features/profile/screens/user_type_screen.dart';
import 'package:vetyo/features/profile/screens/add_farm_screen.dart';
import 'package:vetyo/features/profile/screens/category_selection_screen.dart';
import 'package:vetyo/features/sign_up/screens/google_registration_complete_flow.dart';
import 'package:vetyo/features/sign_up/screens/input_profile_info_screen.dart';
import 'package:vetyo/features/reset_password/screens/reset_password_email_screen.dart';
import 'package:vetyo/features/reset_password/screens/reset_password_otp_screen.dart';
import 'package:vetyo/features/reset_password/screens/reset_password_screen.dart';
import 'package:vetyo/features/reset_password/screens/reset_password_success_screen.dart';
import 'package:vetyo/features/sign_up/screens/doctor_details_input_screen.dart';
import 'package:vetyo/features/sign_up/screens/signup_screen.dart';
import 'package:vetyo/features/sign_up/screens/google_registration_complete_screen.dart';
import 'package:vetyo/features/sign_up/screens/user_registration_flow.dart';
import 'package:vetyo/features/vegetable_farming/screens/add_vegetable_screen.dart';
import 'package:vetyo/features/vets/screens/all_vets_screen.dart';
import 'package:vetyo/features/vets/screens/recommend_vets_screen.dart';
import 'package:vetyo/features/vets/screens/vet_screen.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case RoutePaths.splashScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const SSSApp(),
      //   );

      case RoutePaths.customSearchListView:
        final Map typeArgs = args as Map;
        return MaterialPageRoute(
          builder:
              (_) => CustomSearchListView(
                options: typeArgs['options'],
                title: typeArgs['label'],
                showSearch: typeArgs['showSearch'],
              ),
        );
      case RoutePaths.homeScreen:
        final int initialTab = args is int ? args : 0;
        return MaterialPageRoute(
          builder: (_) => HomePage(initialTab: initialTab),
        );

      case RoutePaths.doctorHomeScreen:
        return MaterialPageRoute(builder: (_) => DoctorHomePage());

      case RoutePaths.resetPasswordOTPScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder: (_) => ResetPasswordOTPScreen(email: typeArgs['email']),
        );
      case RoutePaths.resetPasswordEmailScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordEmailScreen(),
        );

      case RoutePaths.followUpscreen:
        return MaterialPageRoute(
          builder: (_) => FollowUpFlowScreen(initialPage: 0),
        );

      case RoutePaths.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.oTPVerifySuccessScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => OTPVerifySuccessScreen(
                navigatorPath: typeArgs["navigatorPath"],
                otpNumber: typeArgs['otpNumber'] ?? "",
              ),
        );
      case RoutePaths.oTPVerificationScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(email: typeArgs['email']),
        );

      // case RoutePaths.enterProfileInfoScreen:
      //   final Map typeArgs = args as Map? ?? {};
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => EnterProfileInfoScreen(userInfo: typeArgs['userInfo']),
      // );
      case RoutePaths.inputProfileInformationScreen:
        return MaterialPageRoute(
          builder: (_) => const InputProfileInformationScreen(),
        );

      case RoutePaths.categoryProfileScreen:
        return MaterialPageRoute(builder: (_) => const CategoryProfileScreen());
      case RoutePaths.categoryProfileDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const CategoryProfileDetailsScreen(),
        );
      case RoutePaths.userTypeScreen:
        return MaterialPageRoute(builder: (_) => const UserTypeScreen());
      case RoutePaths.addFarmScreen:
        return MaterialPageRoute(builder: (_) => const AddFarmScreen());
      case RoutePaths.editUserProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case RoutePaths.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case RoutePaths.languageScreen:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      case RoutePaths.articleSearchScreen:
        return MaterialPageRoute(builder: (_) => const ArticleSearchScreen());

      case RoutePaths.categorySelectionScreen:
        return MaterialPageRoute(
          builder: (_) => const CategorySelectectionScreen(),
        );
      // case RoutePaths.userInformationInputScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const UserInformationInputScreen(),
      //   );
      case RoutePaths.resetPasswordSuccessScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordSuccessScreen(),
        );
      case RoutePaths.resetPasswordScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => ResetPasswordScreen(
                otpNumber: typeArgs['otpNumber'],
                email: typeArgs['email'] ?? '',
              ),
        );
      case RoutePaths.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RoutePaths.initialScreen:
        return MaterialPageRoute(builder: (_) => const InitialScreen());
      case RoutePaths.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RoutePaths.googleRegistrationCompleteScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => GoogleRegistrationCompleteScreen(
                googleUserData: typeArgs['googleUserData'],
              ),
        );
      case RoutePaths.googleRegistrationCompleteFlow:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => GoogleRegistrationCompleteFlow(
                initialPage: typeArgs['initialPage'] ?? 0,
              ),
        );
      case RoutePaths.userRegistrationFlow:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => UserRegistrationFlow(
                initialPage: typeArgs['initialPage'] ?? 0,
              ),
        );
      case RoutePaths.addRegisterProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const AddRegisterProfileScreen(),
        );
      case RoutePaths.doctorDetailsInputScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => DoctorDetailsInputScreen(formData: typeArgs['formData']),
        );

      case RoutePaths.vetScreen:
        return MaterialPageRoute(builder: (_) => const VetScreen());
      case RoutePaths.allVetScreen:
        return MaterialPageRoute(builder: (_) => const AllVetsScreen());
      case RoutePaths.recommednVetScreen:
        return MaterialPageRoute(builder: (_) => const RecommendVetsScreen());

      case RoutePaths.appointmentScreen:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());

      case RoutePaths.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      case RoutePaths.casePictureScreen:
        return MaterialPageRoute(builder: (_) => const CasePictureScreen());

      case RoutePaths.userCasesScreen:
        return MaterialPageRoute(builder: (_) => const UserCasesScreen());
      case RoutePaths.caseDetailsChatScreen:
        return MaterialPageRoute(
          builder:
              (_) => CaseDetailsChatScreen(
                // caseData: args['caseData']),
              ),
        );

      case RoutePaths.casesMediaScreen:
        return MaterialPageRoute(builder: (_) => const CasesMediaScreen());
      case RoutePaths.closedCaseDetailsScreen:
        return MaterialPageRoute(builder: (_) => const ClosedCaseReport());
      // case RoutePaths.activeCaseDetailsScreen:
      // return MaterialPageRoute(builder: (_) => const ());
      case RoutePaths.activeCaseDetailsScreen:
        return MaterialPageRoute(builder: (_) => const ViewCaseReportScreen());

      case RoutePaths.bookAppointment:
        return MaterialPageRoute(builder: (_) => const BookAppointmentScreen());
      case RoutePaths.appoinmentPaymentScreen:
        return MaterialPageRoute(
          builder: (_) => const AppoinmentPaymentScreen(),
        );

      case RoutePaths.doctorProfileDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const DoctorProfileDetailsScreen(),
        );
      case RoutePaths.editDoctorProfileDetails:
        return MaterialPageRoute(
          builder: (_) => const EditDoctorProfileScreen(),
        );

      case RoutePaths.bookAppoinmentFlow:
        return MaterialPageRoute(builder: (_) => BookAppointmentFlow());

      case RoutePaths.addPetScreen:
        return MaterialPageRoute(builder: (_) => const AddPetScreens());

      case RoutePaths.addPoultryScreen:
        return MaterialPageRoute(builder: (_) => const AddPoultryScreen());

      case RoutePaths.addLivestockScreen:
        return MaterialPageRoute(builder: (_) => const AddLivestockScreen());

      case RoutePaths.addAquaScreen:
        return MaterialPageRoute(builder: (_) => const AddAquaScreen());

      case RoutePaths.addVegetableScreen:
        return MaterialPageRoute(builder: (_) => const AddVegetableScreen());

      case RoutePaths.communityScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => CommunityScreen(initialPage: typeArgs['initialPage'] ?? 0),
        );

      case RoutePaths.addPostScreen:
        return MaterialPageRoute(builder: (_) => const AddPostScreen());

      case RoutePaths.addPollScreen:
        return MaterialPageRoute(builder: (_) => const AddPollScreen());

      case RoutePaths.postDetailScreen:
        final Map typeArgs = args as Map? ?? {};
        return MaterialPageRoute(
          builder:
              (_) => PostDetailsScreen(
                postData: typeArgs['postData'],
                shouldScrollToComment:
                    typeArgs['shouldScrollToComment'] as bool? ?? false,
              ),
        );

      case RoutePaths.favoriteScreen:
        return MaterialPageRoute(builder: (_) => FavoriteScreen());

      case RoutePaths.sharePostScreen:
        return MaterialPageRoute(builder: (_) => const SharePostCardWidget());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const ErrorPage();
          },
        );
    }
  }
}
