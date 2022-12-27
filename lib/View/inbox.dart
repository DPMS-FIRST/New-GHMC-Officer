import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Model/show_notification_response.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

class InboxNotifications extends StatefulWidget {
  const InboxNotifications({super.key});

  @override
  State<InboxNotifications> createState() => _InboxNotificationsState();
}

class _InboxNotificationsState extends State<InboxNotifications> {
  ShowNotificationResponse? showNotificationResponse;
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text(
            TextConstants.notification_inbox,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Text("Avoid 2% monthly interest on Property Taxes"),
                      Text("27-03-2019 17:04:52"),
                      ExpandableText(
                        "Dear Citizen, Please pay your taxes on time to avoid 2% monthly interest. Please note thet monthly interest in any financial year starts from july for the 1st half of the property tax and interest on 2nd half will be imposed from january of the same financial year.",
                        expandText: 'show more',
                        collapseText: 'show less',
                        maxLines: 1,
                        linkColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    var mobile =
        await SharedPreferencesClass().readTheData(PreferenceConstants.mobileno);

//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.baseurl + ApiConstants.inbox_notifications_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
    "userid":"cgg@ghmc",
    "password":"ghmc@cgg@2018",
    "mobileno": mobile 
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

      final data = ShowNotificationResponse.fromJson(response.data);
      // print(response.data);

      setState(() {
        if (data.status == "success") {
          EasyLoading.dismiss();
          showNotificationResponse = data;
        }
      });
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
