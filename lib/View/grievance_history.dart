import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/history_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';

import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class GrievanceHistory extends StatefulWidget {
  const GrievanceHistory({super.key});

  @override
  State<GrievanceHistory> createState() => _GrievanceHistoryState();
}

class _GrievanceHistoryState extends State<GrievanceHistory> {
  GrievanceHistoryResponse? grievanceHistoryResponse;
  // ignore: unused_field
  String? _backgroundImage;
  // ignore: unused_field
  String? _backgroundImage2;
  // ignore: unused_field
  String? _backgroundImage3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TextConstants.grievance_history,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount:
                          grievanceHistoryResponse?.grievance?.length ?? 0,
                      itemBuilder: (context, index) {
                        final details =
                            grievanceHistoryResponse?.grievance?[index];

                        return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black87, width: 1),
                            ),
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                RowComponent(
                                  TextConstants.id,
                                  details?.id,
                                ),
                                RowComponent(
                                 TextConstants.type,
                                  details?.type,
                                ),
                                RowComponent(
                                  TextConstants.time,
                                  details?.timeStamp,
                                ),
                                RowComponent(
                                  TextConstants.mobile_number,
                                  details?.mobileno,
                                  ico: IconButton(
                                    onPressed: (){
                                      launch("tel:${details?.mobileno}");
                                  }, icon: Icon(
                                    Icons.call,
                                    color: Color.fromARGB(255, 40, 133, 43),
                                    ))
                                  
                                ),
                                RowComponent(
                                  TextConstants.status,
                                  details?.status,
                                ),
                                RowComponent(
                                  TextConstants.posted_by,
                                  details?.userName,
                                ),
                                RowComponent(
                                  TextConstants.landmark,
                                  details?.landmark,
                                ),
                                RowComponent(
                                  TextConstants.remarks,
                                  details?.remarks,
                                  
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    setImage(_backgroundImage = details?.photo),
                                    setImage(
                                        _backgroundImage2 = details?.photo2),
                                    setImage(
                                        _backgroundImage3 = details?.photo3),
                                  ],
                                )
                              ],
                            ));
                      })),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Card(
                    color: Colors.transparent,
                    child: textButton(
                      text: TextConstants.view_comments,
                      textcolor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.viewcomment);
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Card(
                    color: Colors.transparent,
                    child: textButton(
                      text: TextConstants.take_action,
                      textcolor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.takeaction);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RowComponent(var data, var value, {IconButton? ico}) {
     //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
         Expanded(
            flex: 1,
           child: Container(child: ico),
          ),
          
        ],
      ),
    );
  }
  setImage(_backgroundImage) {
    if (_backgroundImage.toString().contains('.pdf')) {
      _backgroundImage = ImageConstants.viewpdf;
      return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Image.asset(
          "${_backgroundImage}",
          width: 100,
          height: 80,
        ),
      );
    } else {
      _backgroundImage = ImageConstants.viewimage;
      return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Image.asset(
          "${_backgroundImage}",
          width: 100,
          height: 90,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.history_baseurl + ApiConstants.history_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "compId": compid,
      "Uid": uid
    };

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = GrievanceHistoryResponse.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "success") {
          if (data.grievance != null && data.grievance!.length > 0) {
            grievanceHistoryResponse = data;
          }
        }
      });
      print(grievanceHistoryResponse?.grievance![0]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        //final errorMessage = e.response?.data["message"];
        // showAlert(errorMessage);
      }
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }
}