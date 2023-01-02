import 'package:ghmc_officer/model/concessionaire_pickup_capture_bindplantname_res.dart';
import 'package:ghmc_officer/model/concessionaire_pickup_capturelist_res.dart';
import 'package:ghmc_officer/model/grievance_details_response.dart';
import 'package:ghmc_officer/model/concessionaire_incharge_manual_closing_tickets_res.dart' as manualticketlist;

class Constants {
  Constants._();

  static List<Comments>? commentsItemsList = null;
  static TicketList? ticktetitemslist = null;
  static List<ListVehicles>? vehiclenumbers = null;
  static List<PLANTDTLS>? plantnames = null;
  static final imagePickingOptions = [
    "Take Photo",
    "Choose from Library",
    "cancel"
  ];
  static manualticketlist.TicketList? concessionaireInchargeManualClosingTicketlist = null;
}
