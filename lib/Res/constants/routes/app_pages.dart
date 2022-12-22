import 'package:flutter/material.dart';
import 'package:ghmc_officer/View/GhmcDashboard.dart';
import 'package:ghmc_officer/View/Grievance_details.dart';
import 'package:ghmc_officer/View/check_status.dart';
import 'package:ghmc_officer/View/display_user_details.dart';
import 'package:ghmc_officer/View/grievance_history.dart';
import 'package:ghmc_officer/View/horizantal_stepper.dart';

import 'package:ghmc_officer/View/image_view.dart';
import 'package:ghmc_officer/View/location.dart';
import 'package:ghmc_officer/View/login.dart';
import 'package:ghmc_officer/Repository/SplashScreen.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/View/mpin_page.dart';
import 'package:ghmc_officer/View/otp_screen.dart';
import 'package:ghmc_officer/View/privacy_policy.dart';
import 'package:ghmc_officer/View/full_grievance_details.dart';
import 'package:ghmc_officer/View/raise_grievance.dart';
import 'package:ghmc_officer/View/search.dart';
import 'package:ghmc_officer/View/set_mpin.dart';
import 'package:ghmc_officer/View/stepper.dart';
import 'package:ghmc_officer/View/take_action.dart';
import 'package:ghmc_officer/View/total_grievances.dart';
import 'package:ghmc_officer/View/view_comments.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.mysplashscreen: ((context) => const MySplashScreen()),
      AppRoutes.myloginpage: ((context) => const Loginpage()),
      AppRoutes.mpin: ((context) => const MyMpinDesign()),
      AppRoutes.ghmcdashboard: ((context) => const GhmcDashboard()),
      //AppRoutes.navigation:((context) => const Navigation()),
      AppRoutes.mytotalgrievances: ((context) => const MyTotalGrievances()),
      AppRoutes.privacypolicy: ((context) => const privacyPolicy()),
      AppRoutes.userdetails: ((context) => const UserDetails()),
      AppRoutes.fullgrievancedetails: ((context) =>
          const FullGrievanceDetails()),
      AppRoutes.grievancehistory: ((context) => const GrievanceHistory()),
      AppRoutes.resetmpin: ((context) => const MyResetMpin()),
      AppRoutes.otpscreen: ((context) => const OtpNewScreen()),
      AppRoutes.viewcomment: ((context) => ViewCommentsScreen()),
      AppRoutes.takeaction: ((context) => const ApiResponse()),
      AppRoutes.imageviewpage: ((context) => const ImageViewPage()),
      AppRoutes.listviewsearch: ((context) => const Search()),
      AppRoutes.raisegrievance: ((context) => const RaiseGrievance()),
      AppRoutes.checkstatus: ((context) =>  CheckStatus()),
       AppRoutes.horizantal: ((context) =>  HorizantalStepper()),
       AppRoutes.location_check:(context) => LoactionCheck(),
       AppRoutes.grivancedetails:((context) => GrievanceDetails()),
      AppRoutes.stepper: ((context) => StepperPage(color: Colors.black, curStep: 1, width: 40, titles: ["cart","sawathi","lavanya","Manisha","swapna","ruchitha","teju"],)),
    };
  }
}
