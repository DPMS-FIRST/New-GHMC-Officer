import 'package:flutter/material.dart';
import 'package:ghmc_officer/View/Concessionaire/c_incharge_ticketlist.dart';
import 'package:ghmc_officer/View/GhmcDashboard.dart';
import 'package:ghmc_officer/View/abstract_report.dart';
import 'package:ghmc_officer/View/Concessionaire/c_closed_list.dart';
import 'package:ghmc_officer/View/check_status.dart';
import 'package:ghmc_officer/View/checkstatus_comments.dart';

import 'package:ghmc_officer/View/Concessionaire/c_dashboard.dart';
import 'package:ghmc_officer/View/Concessionaire/c_incharge_manual_closing_ticketes_list.dart';
import 'package:ghmc_officer/View/Concessionaire/c_incharge_manual_closing_tickets.dart';
import 'package:ghmc_officer/View/Concessionaire/c_pickup_capture.dart';

import 'package:ghmc_officer/View/Concessionaire/c_pickup_capturelist.dart';

import 'package:ghmc_officer/View/amoh_dashboard.dart';
import 'package:ghmc_officer/View/Concessionaire/c_rejection_ticketlist.dart';

import 'package:ghmc_officer/View/display_user_details.dart';
import 'package:ghmc_officer/View/fulldetails.dart';
import 'package:ghmc_officer/View/grievance_details.dart';
import 'package:ghmc_officer/View/grievance_history.dart';

import 'package:ghmc_officer/View/image_view.dart';
import 'package:ghmc_officer/View/SplashScreen.dart';
import 'package:ghmc_officer/res/constants/routes/app_routes.dart';
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
import 'package:ghmc_officer/View/simple_groupedlist.dart';
import 'package:ghmc_officer/View/take_action.dart';
import 'package:ghmc_officer/View/total_grievances.dart';
import 'package:ghmc_officer/View/view_comments.dart';
import 'package:ghmc_officer/view/rejected_tickets.dart';
import 'package:ghmc_officer/view/amount_payed.dart';
import 'package:ghmc_officer/view/request_list.dart';

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
     // AppRoutes.grivancedetails: ((Context) => GrievanceDetails()),
      AppRoutes.checkstatus: ((context) => CheckStatus()),
      AppRoutes.checkstatuscomments: ((context) => CheckstatusComments()),
      AppRoutes.postcomment: ((context) => PostComment()),

      AppRoutes.simplegroupedlist:((context) => SimpleGroupedlist()),
      AppRoutes.concessionairedashboard:((context) => ConcessionaireDashboard()),
      AppRoutes.concessionairinchargepickupcapturelist:((context) => ConcessionerPickupCaptureList()),
     AppRoutes.concessionairepickupcapture:((context) => ConcessionairePickupCapture()),

      AppRoutes.consructiondemolitionwaste: ((context) => AmohDashboardList()),
      AppRoutes.requestlist:((context) => AmohRequestList()),
     AppRoutes.amohrequestbylist:((context) => AmohRequestList()),
     AppRoutes.crejectionticketlist:((context) => CRejectionTicketlist()),
     AppRoutes.cclosedlist:((context) =>CClosedList()),
     AppRoutes.cinchargeticketlist:((context) => CInchargeTicketList()),
      AppRoutes.amohamountpayedlist:((context) => AmohAmountPayedList()),
      AppRoutes.rejectedtickets:((context) => ConsessionerRejectedTicketsList()),
      AppRoutes.concessionaireinchargemanualclosingtickets:((context) => ConcessionaireInchargeManualClosingTickets()),
      AppRoutes.concessionaireinchargemanualclosingticketslist:((context) => ConcessionaireInchargeManualClosingTicketsList())

    };
  }
}
