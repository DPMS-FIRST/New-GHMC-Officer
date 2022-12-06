import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/login_response_model.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Model/user_details_response.dart';
import 'package:ghmc_officer/Model/user_list_response.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:ghmc_officer/View/full_grievance_details.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserDetailsResponse? userDetailsResponse;
  GrievanceUserList? grievanceUserList;
  LoginResponse? loginResponse;

  String? name;
  String? desig;
  String? employee_level;
  String? source_name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            TextConstants.display_user_details,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 15.0),
                          child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      RowComponent(
                                        TextConstants.name,
                                         name
                                      ),
                                      RowComponent(
                                        TextConstants.designation,
                                       desig,
                                      ),
                                      RowComponent(
                                        TextConstants.employee_level,
                                        employee_level,
                                      ),
                                      RowComponent(
                                        TextConstants.wing,
                                        userDetailsResponse?.wing
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Center(
                              child: Text(
                                TextConstants.grievance_details_as_on_date,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Text("Source : ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                              ),
                              ),
                              Text("${source_name}",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  userDetailsResponse?.dashboard?.length ?? 0,
                              itemBuilder: (context, index) {
                                final details =
                                    userDetailsResponse?.dashboard?[index];
                                return GestureDetector(
                                  onTap: () {
                                    
                                    SharedPreferencesClass().writeTheData(
                                        PreferenceConstants.fulldetails, details?.typeId);   
                                        //print(details?.typeId);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FullGrievanceDetails(),
                                        ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black87, width: 1),
                                    ),
                                    color: Colors.transparent,
                                    child: ListTile(
                                      title: Text(
                                        "${details?.typeName}",
                             
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: Text(
                                        "${details?.gcount}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
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
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
  
    super.initState();

    GrievanceUserDetails();
  }

  void GrievanceUserDetails() async {
    var modeid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.userdetails);
        var uid = await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
      
   var typeid = await SharedPreferencesClass(). readTheData(PreferenceConstants.typeid);
     var slftype =
        await SharedPreferencesClass().readTheData(PreferenceConstants.totalid);
   var emp_name = await SharedPreferencesClass().readTheData(PreferenceConstants.name);
   var designation = await SharedPreferencesClass().readTheData(PreferenceConstants.designation);
   var sourcename = await SharedPreferencesClass().readTheData(PreferenceConstants.cname);
    //print(sourcename);
    setState(() {
       name = emp_name;
       desig = designation;
       employee_level = typeid;
       source_name = sourcename;
    });
    //creating request url with base url and endpoint
    const requesturl =
        ApiConstants.userdetails_baseurl + ApiConstants.userdetails_endpoint;

    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": uid,
      "mode": modeid,
      "type_id": typeid,
      "slftype": slftype
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
      final data = UserDetailsResponse.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "true") {
          if (data.dashboard != null && data.dashboard!.length > 0) {
            userDetailsResponse = data;
          }
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
