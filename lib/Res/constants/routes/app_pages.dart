import 'package:flutter/material.dart';
import 'package:ghmc_officer/View/GhmcDashboard.dart';
import 'package:ghmc_officer/View/display_user_details.dart';
import 'package:ghmc_officer/View/grievance_history.dart';
import 'package:ghmc_officer/View/login.dart';
import 'package:ghmc_officer/Repository/SplashScreen.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/View/mpin_page.dart';
import 'package:ghmc_officer/View/otp_screen.dart';
import 'package:ghmc_officer/View/privacy_policy.dart';
import 'package:ghmc_officer/View/full_grievance_details.dart';
import 'package:ghmc_officer/View/set_mpin.dart';
import 'package:ghmc_officer/View/take_action.dart';
import 'package:ghmc_officer/View/total_grievances.dart';
import 'package:ghmc_officer/View/view_comments.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
     
       AppRoutes.mysplashscreen:((context) => const MySplashScreen()),
      AppRoutes.myloginpage:((context) => const LoginShared()),
      AppRoutes.mpin:((context) => const MyMpinDesign()),
      AppRoutes.ghmcdashboard:((context) => const GhmcDashboard()),
      //AppRoutes.navigation:((context) => const Navigation()),
      AppRoutes.mytotalgrievances:((context) => const MyTotalGrievances()),
      AppRoutes.privacypolicy:((context) => const PrivacyPolicy()),
      AppRoutes.userdetails:((context) => const UserDetails()),
      AppRoutes.fullgrievancedetails:((context) => const FullGrievanceDetails()),
      AppRoutes.grievancehistory:((context) => const GrievanceHistory()),
      AppRoutes.resetmpin:((context) => const MyResetMpin()),
       AppRoutes.otpscreen:((context) => const OtpNewScreen()),
       AppRoutes.viewcomment:((context) =>  ViewCommentsScreen()),
       AppRoutes.takeaction:((context) => const ApiResponse())
    };
  }
}