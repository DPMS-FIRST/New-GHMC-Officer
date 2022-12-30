import 'package:ghmc_officer/Model/amoh_dashboard_request.dart';
import 'package:ghmc_officer/Network/base_api_client.dart';
import 'package:ghmc_officer/model/amoh_dashboard_response.dart';
import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';

class AmohDashboardRepository {
final _baseClient = BaseApiClient();
 Future<AMOHDashboardListResponse> getAmohDashboardListApi(AMOHDashboradListRequest payload) async{
   final response = await _baseClient.postApi(ApiConstants.amoh_dash_list_endpoint,payload: payload.toJson());
   print("------------------------------${payload.toJson()}");
   return AMOHDashboardListResponse.fromJson(response);  
  }
  
}