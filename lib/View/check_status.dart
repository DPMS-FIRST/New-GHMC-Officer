import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Model/check_status_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/searchbar.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:ghmc_officer/View/stepper.dart';
import 'package:grouped_list/grouped_list.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({super.key});

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  checkStatusResponse? _statusResponse;
  // ViewGrievancePreview? _grievancePreview;
  List<ViewGrievances> viewGrievanceResponse = [];
  List<ViewGrievances> viewGrievanceSearchListResponse = [];

  List<Map<String, String>> d = [];
  List customers = [""];
  dynamic jsonResult;
  dynamic list;
  var check;

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
              // complaint.value="select";
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            "Check Status",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              ReusableSearchbar(
                bgColor: Colors.white,
                screenHeight: 0.05,
                searchIcon: Icon(Icons.search),
                topPadding: 8.0,
                onChanged: (value) => _runFilter(value),
                screenWidth: 1,
                onPressed: () {},
              ),
              Expanded(
                child: GroupedListView<dynamic, String>(
                  
                  stickyHeaderBackgroundColor: Colors.amber,
                  elements: d,
                  groupBy: (element) => element["Subcategory Name"],
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  /*  itemComparator: (item1, item2) =>
                      item1['ID'].compareTo(item2['ID']), */
                  // order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: false,
                  groupSeparatorBuilder: (String value) => SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.black,
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                    
                  indexedItemBuilder: ((context, ele, index) {
                   // var details = viewGrievanceSearchListResponse[index];
                   // print("index ${viewGrievanceSearchListResponse[index].assignedto}");
                   //  print("element ${ele["Subcategory Name"]}");
                    //  print(index);

                    // print( d.where((ViewGrievances) =>
                    //     ViewGrievances["type"] == ele["type"]));

                    // (d.map((e) => e[" Subcategory Name"] == ele["type"]));
                    /*  d.map((e) {
                      if (e[" Subcategory Name"] == ele["type"]) {
                        print("true");
                      } else {
                        print("no");
                      }
                    }); */
                    // print("checking ${check}");
                    /* d.map(
                      (e) {
                        print("elements of e ${e}");
                      },
                    ); */

                    return GestureDetector(
                      onTap: () {
                        SharedPreferencesClass().writeTheData(
                            PreferenceConstants.check_status_id, ele["ID"]);
                           
                        Navigator.pushNamed(context, AppRoutes.grivancedetails);
                         EasyLoading.show();
                      },
                      child: Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowComponent(
                              TextConstants.check_status_id, ele["ID"]),
                          Line(),
                          RowComponent(TextConstants.check_status_category_name,
                              ele["Category Name"]),
                          Line(),
                          RowComponent(
                              TextConstants.check_status_subcategory_name,
                              ele["Subcategory Name"]),
                          Line(),
                          RowComponent(TextConstants.check_status_time_stamp,
                              ele["Time stamp"]),
                          Line(),
                          RowComponent(TextConstants.check_status_assigned_to,
                              ele["Assigned to"]),
                          Line(),
                          RowComponent(
                              TextConstants.check_status_status, ele["Status"]),
                          Column(
                            children: [
                              StepperPage(
                                  curStep: 1,
                                  titles: [
                                    "Open",
                                    "Under Process",
                                    "Resolved By Officer",
                                    "Closed By Citizen",
                                    "Condition Closed"
                                  ],
                                  width: 10.0,
                                  color: Colors.black),
                            ],
                          ),
                        ],
                      )),
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rights Reserved @ GHMC",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Powered By CGG",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      /*  bottomSheet: Container(
        color: Colors.transparent,
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rights Reserved @ GHMC",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Powered By CGG",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ) */
    );
  }

  checkStatusDetails() async {
    final check_status_url =
        ApiConstants.baseurl + ApiConstants.check_status_endpoint;
    final check_status_payload = {
      "mobileno": "8008554962",
      "password": "ghmc@cgg@2018",
      "userid": "cgg@ghmc"
    };
    final dio_obj = Dio();
    try {
      final check_status_response =
          await dio_obj.post(check_status_url, data: check_status_payload);
      // print(check_status_response.data);

      final data = checkStatusResponse.fromJson(check_status_response.data);
      final j = data.toJson;
      // print(j);
      setState(() {
        if (data != null && data.status == "success") {
          EasyLoading.dismiss();
          _statusResponse = data;
        }
      });

      // print(_statusResponse?.viewGrievances);

      //print(customers);

      var len = _statusResponse?.viewGrievances?.length ?? 0;
      for (var i = 0; i < len; i++) {
        var item = _statusResponse?.viewGrievances?[i];

        d.add({
          TextConstants.check_status_id: item?.id ?? "",
          TextConstants.check_status_assigned_to: item?.assignedto ?? "",
          TextConstants.check_status_category_name: item?.category ?? "",
          TextConstants.check_status_subcategory_name: item?.type ?? "",
          TextConstants.check_status_time_stamp: item?.timestamp ?? "",
          TextConstants.check_status_status: item?.status ?? "",
        });
      }

      // print(d);
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatusDetails();
    fetchjsondata();
    print(check);

    // groupEmployeesByCountryAndCity(_items);
  }

  RowComponent(var data, var val) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              //Text("${data}",style: TextStyle(decoration: TextDecoration.underline),)
              child: TextWidget(
                text: "${data}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.black54,
              )),
          Expanded(
              flex: 2,
              child: TextWidget(
                text: "${val}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.blueGrey,
              ))
        ],
      ),
    );
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  jsondetails(String k, String v) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            k,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            v,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  fetchjsondata() async {
    String jsondata =
        await rootBundle.loadString('assets/check_status_json_data.json');

    setState(() {
      jsonResult = json.decode(jsondata);
    });
    //  print(jsonResult["viewGrievances"]);
    list = jsonResult["viewGrievances"];
    // print(list);
  }

  _runFilter(String enteredKeyword) {
    List<ViewGrievances> results = [];
    if (enteredKeyword.isEmpty) {
      results = viewGrievanceResponse;
    } else {
      // print(enteredKeyword);
      results = viewGrievanceResponse
          .where((element) =>
              element.id!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      setState(() {
        viewGrievanceSearchListResponse = results;
        // print(viewGrievanceSearchListResponse.length);
      });
    }
  }
}
