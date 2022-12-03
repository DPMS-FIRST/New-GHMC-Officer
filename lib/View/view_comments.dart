import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Model/history_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/appbar.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/service_text.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCommentsScreen extends StatefulWidget {
  ViewCommentsScreen({
    super.key,
  });

  //bool errorFoundInImageLoad = false;

  @override
  State<ViewCommentsScreen> createState() => _ViewCommentsScreenState();
}

class _ViewCommentsScreenState extends State<ViewCommentsScreen> {
  //ViewCommentsModel? _viewCommentsModel;
 GrievanceHistoryResponse? grievanceHistoryResponse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      child: Stack(
        children: <Widget>[
          BgImage(imgPath: "bg.png"),
          ReusableAppbar(
            topPadding: 20,
            screenWidth: 1,
            screenHeight: 0.08,
            bgColor: Colors.white,
            appIcon: Icon(Icons.arrow_back),
            title: "view Comments",
            fontSize: 15,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              child: ListView.builder(
                  itemCount: grievanceHistoryResponse?.comments?.length,
                  itemBuilder: ((context, index) {
                    var item = grievanceHistoryResponse?.comments?[index];
                    //final String imageURL = item?.cphoto ?? "";

                    // print(item);
                    // print(_viewCommentsModel?.comments?[0].clatlon);
                    return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black87, width: 1),
                        ),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ServiceTextLabel(text: "PostedBy"),
                                    ServiceTextLabel(text: "ID"),
                                    ServiceTextLabel(text: "Status"),
                                    ServiceTextLabel(text: "Time Stamp"),
                                    ServiceTextLabel(text: "Remarks"),
                                    ServiceTextLabel(text: "Mobile"),
                                    //ServiceTextLabel(text: ""), 
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   ServiceText(text: "${item?.cuserName}"),
                                  ServiceText(text: "${item?.cid}"),
                                  ServiceText(text: "${item?.cstatus}"),
                                  ServiceText(text: "${item?.ctimeStamp}"),
                                  ServiceText(text: "${item?.cremarks}"),
                                  Row(
                                    children: [
                                      ServiceText(text: "${item?.cmobileno}"),
                                      IconButton(
                                        onPressed: () =>
                                            launch("tel:${item?.cmobileno}"),
                                        icon: Icon(Icons.call,),color: Colors.green,
                                      ), 
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                  })),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
   
    super.initState();
     EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
   fetchDetails();

  }

  void fetchDetails() async {
      var compid = await SharedPreferencesClass()
       .readTheData(PreferenceConstants.historydetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
    const url =
        "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/viewGrievanceHistory1";
    final pload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "compId": compid,
      "Uid": uid
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);

      print(_response.data);
      final data = GrievanceHistoryResponse.fromJson(_response.data);
      if (data.comments == null) {
        print("no comments");
      } else {
        setState(() {
          grievanceHistoryResponse = data;

        });
        await EasyLoading.dismiss();

        //var len = _viewCommentsModel?.comments?.length;
      /*   print(_viewCommentsModel?.comments?.length);
        print(_viewCommentsModel?.comments?[0].cid); */

        /*  for (var i = 0; i < len!.toInt(); i++) {
          print(_viewCommentsModel?.comments?[i].toJson());
          commentsList.add(_viewCommentsModel?.comments![0]);
        } */
      }
    } on DioError catch (e) {
      print(e);
    }
  }

 /*  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    } */
  }
  /*  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:7995490649";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //ShowSnackBar.showSnackBar(context, "Unable to call $phoneNumber");
    }

    return;
  } */

