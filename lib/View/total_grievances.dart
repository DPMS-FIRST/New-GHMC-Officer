import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Model/user_details_response.dart';
import 'package:ghmc_officer/Model/user_list_response.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/logo_details.dart';
import 'package:ghmc_officer/Res/components/navigation.dart';
import 'package:ghmc_officer/Res/components/searchbar.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/View/display_user_details.dart';

class MyTotalGrievances extends StatefulWidget {
  const MyTotalGrievances({super.key});

  @override
  State<MyTotalGrievances> createState() => _MyTotalGrievances();
}

class _MyTotalGrievances extends State<MyTotalGrievances> {
  GrievanceUserList? grievanceUserList;
  UserDetailsResponse? userDetailsResponse;

  String p_modeid = "";
  String w_modeid = "";
  String c_modeid = "";
  String m_modeid = "";
  String s_modeid = "";
  String o_modeid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ReusableNavigation(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  /* title: const Text("GHMC Officer App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )), */
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              child: LogoAndDetails(),
                            ),
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
                child: Stack(
              children: [
                /* Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search by Complaint Id',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Colors.black), //<-- SEE HERE
                        ),
                        icon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ))),
                  ),

                ), */
                ReusableSearchbar(
                  bgColor: Colors.white, 
                  screenHeight: 0.08, 
                  searchIcon: Icon(Icons.search), 
                  topPadding: 20.0, 
                  onPressed: () {  }, 
                  screenWidth: 1,),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: ListView.builder(
                    itemCount: grievanceUserList?.rOW?.length ?? 0,
                    itemBuilder: (context, index) {
                      final datalist = grievanceUserList?.rOW?[index];
                     
                      return GestureDetector(
                        onTap: () async {
                          await SharedPreferencesClass()
                              .writeTheData(PreferenceConstants.userdetails, datalist?.mODEID);
                              //print(datalist?.mODEID);
                          await SharedPreferencesClass().writeTheData(PreferenceConstants.cname, datalist?.cNAME);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetails()));
           
                        },
                        
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black87, width: 1),
                          ),
                          color: Colors.transparent,
                          child: ListTile(
                            leading: Image.network(
                              "${datalist?.iURL}",
                              height: 40.0,
                            ),
                            title: Center(
                                child: Text(
                              "${datalist?.cNAME}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                            trailing: Text(
                              "${datalist?.mCOUNT}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget createDrawerItem({required String maintext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Text(
            maintext,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
  
    super.initState();

    GrievanceUserDetails();
  }

  void GrievanceUserDetails() async {
    var slftype =
        await SharedPreferencesClass().readTheData(PreferenceConstants.totalid);
    var uid = await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
   var typeid = await SharedPreferencesClass(). readTheData(PreferenceConstants.typeid);
    //print(id);
    //creating request url with base url and endpoint
    const requesturl =
        ApiConstants.userlist_baseurl + ApiConstants.userlist_endpoint;

    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": uid,
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
      final data = GrievanceUserList.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "true") {
          if (data.rOW != null && data.rOW!.length > 0) {
            grievanceUserList = data;
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

