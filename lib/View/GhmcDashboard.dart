import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Model/dashboard_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/grievance_row.dart';
import 'package:ghmc_officer/Res/components/logo_details.dart';
import 'package:ghmc_officer/Res/components/navigation.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:ghmc_officer/View/total_grievances.dart';

class GhmcDashboard extends StatefulWidget {
  const GhmcDashboard({super.key});

  @override
  State<GhmcDashboard> createState() => _GhmcDashboardState();
}

class _GhmcDashboardState extends State<GhmcDashboard> {
  late DashboardResponse grievanceData;
  String tota = "";
  String totalid = "";
  String totalnumber = "";

  String slumname = "";
  String slumid = "";
  String slumcount = "";

  String allname = "";
  String allid = "";
  String allcount = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ReusableNavigation(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              /* title: const Text("GHMC Officer App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )), */
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  /* title: Center(
                    child: Container(
                      child: LogoAndDetails(),
                    ),
                  ), */
                  collapseMode: CollapseMode.pin,
                  background: SizedBox(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.asset(
                          ImageConstants.bg,
                          fit: BoxFit.fill,
                      ),
                        ),
                        Center(
                          child: Container(
                            child: LogoAndDetails(),
                          ),
                        )
                      ],
                    ),
                  ),
                  ),
            ),
          ];
        },
        body: Stack(
          children: [
            BgImage(imgPath: ImageConstants.bg),
            Container(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      SharedPreferencesClass()
                          .writeTheData(PreferenceConstants.totalid, totalid);
                        EasyLoading.show();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTotalGrievances()));
                              
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(
                          tota,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                        trailing: Text(
                          totalnumber,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (slumcount == "0") {
                        showAlert();
                      } else {
                        SharedPreferencesClass()
                            .writeTheData(PreferenceConstants.totalid, slumid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyTotalGrievances(),
                            ));
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(
                          slumname,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        trailing: Text(
                          slumcount,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      EasyLoading.show();
                      SharedPreferencesClass()
                          .writeTheData(PreferenceConstants.totalid, allid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyTotalGrievances(),
                          ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(
                          allname,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        trailing: Text(
                          allcount,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Grievances(
                        height: 40.0,
                        img: ImageConstants.dash_grievances_icon,
                        text: TextConstants.raise_grievance,
                        textcolor: Colors.white, 
                        onPressed: () {
                          EasyLoading.show();
                            Navigator.pushNamed(context, AppRoutes.raisegrievance);
                          },
                      ),
                      Grievances(
                        height: 40.0,
                        img: ImageConstants.dash_checkstatus,
                        text: TextConstants.check_status,
                        textcolor: Colors.white,
                       onPressed: () {
                          EasyLoading.show();
                          }
                      ),
                      Grievances(
                        img: ImageConstants.construction_icon,
                        height: 50,
                        text: TextConstants.CNDW,
                        textcolor: Colors.white,
                        onPressed: () {
                          EasyLoading.show();
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
             
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GrievanceDetails();
  }

  void GrievanceDetails() async {
   var uid = await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
   var typeid = await SharedPreferencesClass(). readTheData(PreferenceConstants.typeid);
    //creating request url with base url and endpoint
    const requesturl = ApiConstants.baseurl + ApiConstants.endpoint;

    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": uid,
      "type_id": typeid
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
      final data = DashboardResponse.fromJson(response.data);
      //print(response.data);
      
      setState(() {
        if (data.status == "true") {
          EasyLoading.dismiss();
          if (data.row != null && data.row!.length > 0) {
            String tot = data.row![0].total!;
            final splitted = tot.split('-');
            tota = splitted[2];
            totalid = splitted[1];
            totalnumber = splitted[0];

            String slum = data.row![0].sLF!;
            final slumsplit = slum.split('-');
            slumname = slumsplit[2];
            slumid = slumsplit[1];
            slumcount = slumsplit[0];

            String all = data.row![0].nONSLF!;
            final allsplit = all.split('-');
            allname = allsplit[2];
            allid = allsplit[1];
            allcount = allsplit[0];

          }
        }
      });
    EasyLoading.dismiss();
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

  showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(TextConstants.no_grievance_available),
            // title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  //print("clicked");
                  // print("button Action");
                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
                //style: ButtonStyle(backgroundColor:),
              )
            ],
          );
        }); //showDialog
  } //

}
