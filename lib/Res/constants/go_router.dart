import 'package:flutter/material.dart';
import 'package:ghmc_officer/res/constants/route_list.dart';
import 'package:ghmc_officer/view/GhmcDashboard.dart';
import 'package:ghmc_officer/view/SplashScreen.dart';
import 'package:ghmc_officer/view/abstract_report.dart';
import 'package:ghmc_officer/view/amoh_dashboard.dart';
import 'package:ghmc_officer/view/check_status.dart';
import 'package:ghmc_officer/view/checkstatus_comments.dart';
import 'package:ghmc_officer/view/display_user_details.dart';
import 'package:ghmc_officer/view/fulldetails.dart';
import 'package:ghmc_officer/view/grievance_details.dart';
import 'package:ghmc_officer/view/grievance_history.dart';
import 'package:ghmc_officer/view/grievance_type.dart';
import 'package:ghmc_officer/view/image_view.dart';
import 'package:ghmc_officer/view/inbox.dart';
import 'package:ghmc_officer/view/loginpage.dart';
import 'package:ghmc_officer/view/mpin_page.dart';
import 'package:ghmc_officer/view/new_complaint.dart';
import 'package:ghmc_officer/view/otp_screen.dart';
import 'package:ghmc_officer/view/pdf_view.dart';
import 'package:ghmc_officer/view/post_comment.dart';
import 'package:ghmc_officer/view/privacy_policy.dart';
import 'package:ghmc_officer/view/set_mpin.dart';
import 'package:ghmc_officer/view/take_action.dart';
import 'package:ghmc_officer/view/total_grievances.dart';
import 'package:ghmc_officer/view/view_comments.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: RoutesList.ghmcdashboard,
  routes: <RouteBase>[
    GoRoute(
        path: RoutesList.mysplashscreen,
        builder: (BuildContext context, GoRouterState state) {
          return const MySplashScreen();
        }),
    GoRoute(
      path: RoutesList.myloginpage,
      builder: (BuildContext context, GoRouterState state) {
        return const Loginpage();
      },
    ),
    GoRoute(
      path: RoutesList.mpin,
      builder: (BuildContext context, GoRouterState state) {
        return const MyMpinDesign();
      },
    ),
    GoRoute(
      path: RoutesList.ghmcdashboard,
      builder: (BuildContext context, GoRouterState state) {
        return const GhmcDashboard();
      },
    ),
    GoRoute(
      path: RoutesList.mytotalgrievances,
      builder: (BuildContext context, GoRouterState state) {
        return const MyTotalGrievances();
      },
    ),
    GoRoute(
      path: RoutesList.privacypolicy,
      builder: (BuildContext context, GoRouterState state) {
        return const privacyPolicy();
      },
    ),
    GoRoute(
      path: RoutesList.userdetails,
      builder: (BuildContext context, GoRouterState state) {
        return const UserDetails();
      },
    ),
    GoRoute(
      path: RoutesList.grievancehistory,
      builder: (BuildContext context, GoRouterState state) {
        return const GrievanceHistory();
      },
    ),
    GoRoute(
      path: RoutesList.fullgrievancedetails,
      builder: (BuildContext context, GoRouterState state) {
        return const FullGrievanceDetails();
      },
    ),
    GoRoute(
      path: RoutesList.resetmpin,
      builder: (BuildContext context, GoRouterState state) {
        return const MyResetMpin();
      },
    ),
    GoRoute(
      path: RoutesList.otpscreen,
      builder: (BuildContext context, GoRouterState state) {
        return const OtpNewScreen();
      },
    ),
    GoRoute(
      path: RoutesList.viewcomment,
      builder: (BuildContext context, GoRouterState state) {
        return const ViewCommentsScreen();
      },
    ),
     GoRoute(
      path: RoutesList.takeaction,
      builder: (BuildContext context, GoRouterState state) {
        return const ApiResponse();
      },
    ),
    GoRoute(
      path: RoutesList.imageviewpage,
      builder: (BuildContext context, GoRouterState state) {
        return const ImageViewPage();
      },
    ),
    GoRoute(
      path: RoutesList.raisegrievance,
      builder: (BuildContext context, GoRouterState state) {
        return const RaiseGrievance();
      },
    ),
     GoRoute(
      path: RoutesList.newcomplaint,
      builder: (BuildContext context, GoRouterState state) {
        return const NewComplaint();
      },
    ),
    GoRoute(
      path: RoutesList.pdfViewer,
      builder: (BuildContext context, GoRouterState state) {
        return const PdfViewer();
      },
    ),
    GoRoute(
      path: RoutesList.abstractreport,
      builder: (BuildContext context, GoRouterState state) {
        return const AbstractReport();
      },
    ),
    GoRoute(
      path: RoutesList.inboxnotification,
      builder: (BuildContext context, GoRouterState state) {
        return const InboxNotifications();
      },
    ),
    GoRoute(
      path: RoutesList.grivancedetails,
      builder: (BuildContext context, GoRouterState state) {
        return const GrievanceDetails();
      },
    ),
    GoRoute(
      path: RoutesList.checkstatus,
      builder: (BuildContext context, GoRouterState state) {
        return const CheckStatus();
      },
    ),
    GoRoute(
      path: RoutesList.postcomment,
      builder: (BuildContext context, GoRouterState state) {
        return const PostComment();
      },
    ),
    GoRoute(
      path: RoutesList.checkstatuscomments,
      builder: (BuildContext context, GoRouterState state) {
        return const CheckstatusComments();
      },
    ),
    GoRoute(
      path: RoutesList.amohdashboardlist,
      builder: (BuildContext context, GoRouterState state) {
        return const AmohDashboardList();
      },
    ),
  ],
);
