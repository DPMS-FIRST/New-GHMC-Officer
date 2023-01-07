import 'package:ghmc_officer/model/concessionaire_pickup_capture_bindplantname_res.dart';
import 'package:ghmc_officer/model/concessionaire_pickup_capturelist_res.dart';
import 'package:ghmc_officer/model/grievance_details_response.dart';
import 'package:ghmc_officer/model/concessionaire_incharge_manual_closing_tickets_res.dart'
    as manualticketlist;
import 'package:ghmc_officer/model/amoh/amoh_c_closed_ticketlist_res.dart'
    as amohclosedticketlist;
import 'package:ghmc_officer/model/c_incharge_ticketlist_res.dart'
    as cinchargetickelist;

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
  static manualticketlist.TicketList?
      concessionaireInchargeManualClosingTicketlist = null;
  static amohclosedticketlist.TicketList? amoh_closedticketlist = null;
  static cinchargetickelist.TicketList? c_incharge_ticket_list = null;
  static cinchargetickelist.VehicleList? c_incharge_ticket_list_vehicle_list =
      null;

  static String userid = "cgg@ghmc";
 static String password= "ghmc@cgg@2018";
 
}
