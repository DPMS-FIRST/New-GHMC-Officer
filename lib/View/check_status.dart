import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghmc_officer/Model/check_status_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/appbar.dart';
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
  dynamic? list;
  var check;

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              ReusableAppbar(
                topPadding: 20,
                screenWidth: 1,
                screenHeight: 0.08,
                bgColor: Colors.white,
                appIcon: Icon(Icons.arrow_back),
                title: "Check Status",
                onPressed: (() {
                  Navigator.pop(context);
                }),
                homeIcon: Icon(Icons.home),
                homeTapped: (() {
                  Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                }),
              ),
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
                    //  print("element ${ele["Subcategory Name"]}");
                    //  print(index);

                    // print( d.where((ViewGrievances) =>
                    //     ViewGrievances["type"] == ele["type"]));

                    // (d.map((e) => e[" Subcategory Name"] == ele["type"]));
                    d.map((e) {
                      if (e[" Subcategory Name"] == ele["type"]) {
                        print("true");
                      } else {
                        print("no");
                      }
                    });
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
            ],
          )
        ],
      ),
    );
  }

  checkStatusDetails() async {
    final check_status_url =
        ApiConstants.check_status_baseurl + ApiConstants.check_status_endpoint;
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
                fontWeight: FontWeight.bold,
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

/*
List customers = [];
  customers.add(Customer('Jack', 23));
  customers.add(Customer('Adam', 27));
  customers.add(Customer('Katherin', 25));
 
*/

// print("kjjgjhgjh${_items.length}");

// print(_statusResponse?.viewGrievances?.length);
/*  var len = _statusResponse?.viewGrievances?.length ?? 0;
      for (var i = 0; i < len; i++) {
        view.add(_statusResponse?.viewGrievances?[i]);
      } */
// print(view);

/* Expanded(
                child: ListView.builder(
                    //  shrinkWrap: false,
                    itemCount: _statusResponse?.viewGrievances?.length,
                    itemBuilder: ((context, index) {
                      var details = _statusResponse?.viewGrievances?[index];
                      return Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowComponent(TextConstants.id, details?.id),
                          RowComponent(TextConstants.check_status_category_name,
                              details?.category),
                          RowComponent(
                              TextConstants.check_status_subcategory_name,
                              details?.type),
                          RowComponent(TextConstants.check_status_time_stamp,
                              details?.timestamp),
                          RowComponent(TextConstants.check_status_assigned_to,
                              details?.assignedto),
                          RowComponent(TextConstants.check_status_status,
                              details?.status),
                         /*  Card(
                             
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                      children: _iconViews(),
                                      ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //children: _titleViews(),
                                  ),
                                ],
                              )) */
                          StepperPage(curStep: 1, titles: ["Open","Under Process","Resolved By Officer","Closed By Citizen","Condition Closed"], width: 40, color: Colors.black)
                      , 
                        ],
                      ));
                    })),
              ) */

//grouprdlist
/* itembuilder:(c, element) {
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          /*  leading: ImageIcon(NetworkImage(
                              'http://www.pngall.com/wp-content/uploads/2017/04/IPL-Logo-2017-PNG.png')), */
                          title: Text("Hii"),
                        ),
                      ),
                    );
                  }, */

/*
if (viewGrievanceBeanRes.getStatus().equals("success")) {
                            list = viewGrievanceBeanRes.getViewGrievances();

                            uniqueList.clear();

                            mapstring.clear();

                            for (int i = 0; i < list.size(); i++) {
                                if (!uniqueList.contains(list.get(i).getType())) {
                                    uniqueList.add(list.get(i).getType());
                                }
                            }

                            HeaderBeanList.clear();

                            for (int grouplist = 0; grouplist < uniqueList.size(); grouplist++) {
                                List<ViewGrievance> UpdatedTemp = new ArrayList<>();
                                ArrayList<ViewGrievance> viewGrievanceBeanList = new ArrayList<ViewGrievance>();

                                for (int childList = 0; childList < list.size(); childList++) {
                                    if (uniqueList.get(grouplist).equalsIgnoreCase(list.get(childList).getType())) {
                                        UpdatedTemp.add(list.get(childList));
                                        viewGrievanceBeanList.add(list.get(childList));
                                        headerBean = new HeaderBean(uniqueList.get(grouplist), viewGrievanceBeanList);
                                    }

                                }
                                HeaderBeanList.add(headerBean);
                                // mapstring.put(uniqueList.get(grouplist),UpdatedTemp);


                            }
                            expandableListAdapter = new CustomExpandableListAdapter(getApplicationContext(), HeaderBeanList);
                            binding.expandableListView.setAdapter(expandableListAdapter);


                        } else {
                            AlertDialog.Builder ad = new AlertDialog.Builder(CheckStatusActivity.this);
                            ad.setMessage("" + viewGrievanceBeanRes.getMessage());
                            ad.setCancelable(false);
                            ad.setPositiveButton(getResources().getString(R.string.ok), new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    dialog.dismiss();
                                    finish();
                                }
                            });
                            ad.show();
                        }
*/
