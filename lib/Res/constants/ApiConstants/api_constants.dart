class ApiConstants {
  static const String baseurl =
      "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/";

  static const String endpoint = "GetAllCount";

  static const String login_endpoint = "getMpin";

  static const String userlist_endpoint = "UserList";

  static const String userdetails_endpoint = "validategrievance";

  static const String fulldetails_endpoint = "viewTypeGrievances";

  static const String history_endpoint = "viewGrievanceHistory1";

  static const String search_endpoint = "viewGrievanceHistory1";

  static const String raise_grievance_endpoint = "CategoryList";

  static const String resend_otp_endpoint = "ResendOTP";

  static const String new_complaint_endpoint = "getSubCategoty";

  static const String get_ward_endpoint = "getWard";

  static const String get_lower_staff_endpoint = "getLowerStaff";

  static const String update_grievance_end_point = "updateGrievance";

  static const String check_status_endpoint = "viewGrievances";

  static const String grievance_details_endpoint = "getGrievanceStatusCitizen";

  static const String postcomment_endpoint = "updateGrievance";

  static const String abstract_report_endpoint = "empAbstractProfile";

  static const String inbox_notifications_endpoint = "ShowNotifications";

  // CONCESSIONAIRE

  static const String concessionaire_baseurl =
      "https://qaghmc.cgg.gov.in/CNDMAPI/CNDM/";

  static const String concessionaire_dashboard_endpoint =
      "GET_CONCESSIONER_DASHBOARD_LIST";

  static const String concessionaire_incharge_pickup_capturelist_endpoint =
      "GET_CONCESSIONER_PICKUP_CAPTURE_LIST";

  static const String
      concessionaire_incharge_pickup_capture_bind_plant_name_endpoint =
      "BIND_PLANT_NAME";

  static const String concessionaire_incharge_pickup_capture_vehicletypes = "GetVehicleTypes";
}
