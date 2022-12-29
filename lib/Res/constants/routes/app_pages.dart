import 'package:flutter/material.dart';
import 'package:ghmc_officer/View/GhmcDashboard.dart';
import 'package:ghmc_officer/View/abstract_report.dart';
import 'package:ghmc_officer/View/check_status.dart';
import 'package:ghmc_officer/View/checkstatus_comments.dart';
import 'package:ghmc_officer/View/cndw.dart';
import 'package:ghmc_officer/View/display_user_details.dart';
import 'package:ghmc_officer/View/fulldetails.dart';
import 'package:ghmc_officer/View/grievance_details.dart';
import 'package:ghmc_officer/View/grievance_history.dart';
import 'package:ghmc_officer/View/grouped_list.dart';
import 'package:ghmc_officer/View/image_view.dart';
import 'package:ghmc_officer/Repository/SplashScreen.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/View/inbox.dart';
import 'package:ghmc_officer/View/loginpage.dart';
import 'package:ghmc_officer/View/mpin_page.dart';
import 'package:ghmc_officer/View/new_complaint.dart';
import 'package:ghmc_officer/View/new_mpin_page.dart';
import 'package:ghmc_officer/View/new_view_comments.dart';
import 'package:ghmc_officer/View/otp_screen.dart';
import 'package:ghmc_officer/View/pdf_view.dart';
import 'package:ghmc_officer/View/post_comment.dart';
import 'package:ghmc_officer/View/privacy_policy.dart';
import 'package:ghmc_officer/View/grievance_type.dart';
import 'package:ghmc_officer/View/set_mpin.dart';
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
      AppRoutes.raisegrievance: ((context) => const RaiseGrievance()),
      AppRoutes.newcomplaint: ((context) => const NewComplaint()),
      AppRoutes.pdfViewer: ((context) => const PdfViewer()),
      AppRoutes.newmpin: ((context) => const Mpin()),
      AppRoutes.newviewcomments: ((context) => NewViewComments()),
      AppRoutes.abstractreport: ((context) => AbstractReport()),
      AppRoutes.inboxnotification: ((context) => InboxNotifications()),
      AppRoutes.grivancedetails: ((Context) => GrievanceDetails()),
      AppRoutes.checkstatus: ((context) => CheckStatus()),
      AppRoutes.checkstatuscomments: ((context) => CheckstatusComments()),
      AppRoutes.postcomment: ((context) => PostComment()),
      AppRoutes.myapp: ((context) => MyApp()),
    };
  }
}
