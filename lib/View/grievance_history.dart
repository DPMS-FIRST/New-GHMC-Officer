import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/history_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/service_text.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';

import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';

class GrievanceHistory extends StatefulWidget {
  const GrievanceHistory({super.key});

  @override
  State<GrievanceHistory> createState() => _GrievanceHistoryState();
}

class _GrievanceHistoryState extends State<GrievanceHistory> {
  GrievanceHistoryResponse? grievanceHistoryResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Grievance History",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImage(imgPath: 'bg.png'),
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
                                  "ID",
                                  details?.id,
                                ),
                                RowComponent(
                                  "Type",
                                  details?.type,
                                ),
                                RowComponent(
                                  "Time",
                                  details?.timeStamp,
                                ),
                                RowComponent(
                                  "Mobile No",
                                  details?.mobileno,
                                ),
                                RowComponent(
                                  "Status",
                                  details?.status,
                                ),
                                RowComponent(
                                  "Posted By",
                                  details?.userName,
                                ),
                                RowComponent(
                                  "Landmark",
                                  details?.landmark,
                                ),
                                RowComponent(
                                  "Remarks",
                                  details?.remarks,
                                ),
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
                      text: "VIEW COMMENTS",
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
                      text: "TAKE ACTION",
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

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    var id = await SharedPreferencesClass().readTheData(PreferenceConstants.historydetails);
    print(id);
//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.history_baseurl + ApiConstants.history_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "compId": id,
      "Uid": "978"
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

/* Column(
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ServiceTextLabel(text: "ID"),
                                   ServiceTextLabel(text: "Type"),
                                    ServiceTextLabel(text: "Time"),
                                    ServiceTextLabel(text: "Mobile No"),
                                    ServiceTextLabel(text: "Status"),
                                    ServiceTextLabel(text: "Posted By"),
                                    ServiceTextLabel(text: "Landmark"),
                                    ServiceTextLabel(text: "Remarks"), 
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 15.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     
                                     ServiceText(text: "${details?.id}"),
                                      ServiceText(text: "${details?.type}"),
                                      ServiceText(
                                          text: "${details?.timeStamp}"),
                                      ServiceText(text: "${details?.mobileno}"),
                                      ServiceText(text: "${details?.gstatus}"),
                                      ServiceText(text: "${details?.userName}"),
                                      ServiceText(text: "${details?.landmark}"),
                                      ServiceText(text: "${details?.remarks}"), 
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                         /*  Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                 "assets/viewimage.png",
                                  height: 80.0,
                                ),

                                Image.asset(
                                 "assets/viewimage.png",
                                  height: 80.0,
                                ),

                                Image.asset(
                                 "assets/viewimage.png",
                                  height: 80.0,
                                ),
                                
                              ],
                            ),
                          ) */
                        ]), */
