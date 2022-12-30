import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Res/components/searchbar.dart';
import 'package:ghmc_officer/model/request_list_response.dart';
import 'package:ghmc_officer/model/shared_model.dart';
import 'package:ghmc_officer/res/components/background_image.dart';
import 'package:ghmc_officer/res/components/sharedpreference.dart';
import 'package:ghmc_officer/res/components/textwidget.dart';
import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/res/constants/text_constants/text_constants.dart';

class AmohRequestList extends StatefulWidget {
  const AmohRequestList({super.key});

  @override
  State<AmohRequestList> createState() =>
      _AmohRequestListState();
}

class _AmohRequestListState
    extends State<AmohRequestList> {
  RequestListResponse? requestListResponse;
 
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
                Navigator.pushNamed(context, AppRoutes.consructiondemolitionwaste);
              },
            ),
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: (() {
                Navigator.of(context).pop();
              })
              //() => Navigator.of(context).pop(),
              ),
          title: Center(
            child: Text(
              "Request List",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                  onChanged: (value) => {},
                  screenWidth: 1,
                  onPressed: () {},
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          itemCount: requestListResponse?.aMOHList?.length ?? 0,
                          itemBuilder: (context, index) {
                            final details = requestListResponse?.aMOHList?[index];
                                
                            return GestureDetector(
                              onTap: () async {
                                /*  await SharedPreferencesClass().writeTheData(
                                  PreferenceConstants.historydetails, details.id); */
                                //print(details?.id);
                                //EasyLoading.show();
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GrievanceHistory(),
                                  )); */
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black87, width: 1),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      children: [
                                        RowComponent(
                                          TextConstants
                                              .ticketid,
                                          details?.tICKETID,
                                        ),
                                        Line(),
                                        RowComponent(
                                          TextConstants
                                              .location,
                                          details?.lOCATION,
                                        ),
                                        Line(),
                                        RowComponent(
                                          TextConstants
                                              .date,
                                          details?.cREATEDDATE,
                                        ),
                                        Line(),
                                        RowComponent(
                                          TextConstants
                                              .estimatedwasteintons,
                                          details?.eSTWT,
                                        ),
                                        Line(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8.0),
                                          child: Image.network(
                                            "${details?.iMAGE1PATH}",
                                            height: 100.0,
                                            width: 100.0,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Text(
                                                  ""); 
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
              ],
            ),
          ],
        ));
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  showAlertImage(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            actions: [
              Center(
                  child: Container(
                      child: Image.network(
                photo!,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageConstants.no_uploaded);
                },
              ))),
            ],
          );
        });
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Color.fromARGB(255, 125, 120, 120),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }
  
  getdetails() async {
   
    const requestUrl =
        ApiConstants.cndw_baseurl + ApiConstants.amoh_request_list_endpoint;


    final dioObject = Dio();

    try {
      final response = await dioObject.get(
        requestUrl,
      );

      //converting response from String to json
      final data = RequestListResponse.fromJson(response.data);
      print(response.data);
      setState(() {
        if (data.sTATUSCODE == "200") {
          EasyLoading.dismiss();
          if (data.aMOHList != null) {
            requestListResponse = data;
          }
        }
        else if (data.sTATUSCODE == "600"){
          
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
  }
  showAlert(String message, {String text = ""}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
              text: message + text,
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              fontsize: 15,
            ),
            // title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  print("clicked");
                  // print("button Action");
                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
                //style: ButtonStyle(backgroundColor,
              )
            ],
          );
        }); //showDialog
  }
  
  //

}