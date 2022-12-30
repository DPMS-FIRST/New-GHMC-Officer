import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/amoh_dashboard_request.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/network/base_api_client.dart';
import 'package:ghmc_officer/repository/amoh_dashboard_repository.dart';
import 'package:ghmc_officer/res/constants/route_list.dart';
import 'package:ghmc_officer/res/constants/text_constants/text_constants.dart';
import 'package:go_router/go_router.dart';

class AMOHDashboardViewModel with ChangeNotifier {
  final _amohdashboardrepository = AmohDashboardRepository();

  getAmohDashboardList(BuildContext context) async {
    //AppLoader.showLoader(message: "login...");
    // EasyLoading.show();
    var tokenid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.tokenId);
    var empid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.empd);
    final amohDashboardListReq = AMOHDashboradListRequest(
        eMPLOYEEID: empid, dEVICEID: "564858457848", tOKENID: tokenid);
    final result = await _amohdashboardrepository
        .getAmohDashboardListApi(amohDashboardListReq);
    //AppLoader.hideLoader();
    if (result.sTATUSCODE == ApiErrorCodes.success) {
      //context.go('/details');
      GoRouter.of(context).go(RoutesList.ghmcdashboard);
    } else if (result.sTATUSCODE == ApiErrorCodes.failure) {
      showAlert("${result.sTATUSMESSAGE}", context);
      
    } else if (result.sTATUSCODE == ApiErrorCodes.invalid) {
      showAlert("Server not responding", context);
    } else {}
    notifyListeners();
  }
  showAlert(String msg, BuildContext context) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(msg),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(TextConstants.ok),
                  )
                ],
              );
            }); //showDialog
      }
}
