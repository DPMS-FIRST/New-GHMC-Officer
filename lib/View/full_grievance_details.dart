import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/full_details_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/View/grievance_history.dart';

class FullGrievanceDetails extends StatefulWidget {
  const FullGrievanceDetails({super.key});

  @override
  State<FullGrievanceDetails> createState() => _FullGrievanceDetailsState();
}

class _FullGrievanceDetailsState extends State<FullGrievanceDetails> {
  GrievanceFullDetails? grievanceFullDetails;
  String? _backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Full Grievance Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath: 'bg.png'),
          Column(
            children: [
              Expanded(
                  child: 
                       ListView.builder(
                          itemCount: grievanceFullDetails?.grievance?.length ?? 0,
                          itemBuilder: (context, index) {
                            final details = grievanceFullDetails?.grievance?[index];
                            return GestureDetector(
                              onTap: () async{
                                await SharedPreferencesClass().writeTheData(
                                    PreferenceConstants.historydetails,
                                    details?.id);
                                    //print(details?.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GrievanceHistory(),
                                    ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black87, width: 1),
                                ),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
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
                                        "Time Stamp",
                                        details?.timestamp,
                                      ),
                                      RowComponent(
                                        "Status",
                                        details?.status,
                                      ),
                                      Row(
                                        children: [
                                            setImage(
                                                details?.photo
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ),
            ],
          ),
        ],
      ),
    );
  }
  
setImage(var _mTitle) {
  return Container(
    
  );
 

      /* if(_mTitle.toString().endsWith(".pdf")) {
        _backgroundImage = "assets/viewpdf.png";
        return Container(
          child: Image.asset("${_backgroundImage}"),
        );
      } else {
        _backgroundImage = "assets/viewimage.png";

      } */ // here it returns your _backgroundImage value

    } 

  /* ImageComponent()
  {
    return GestureDetector(
      onTap: () {
        
      },
      child: ,
    );
  } */

  
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
    var id = await SharedPreferencesClass()
       .readTheData(PreferenceConstants.fulldetails);
    //   var id = await SharedPreferencesClass().readTheData( PreferenceConstants.historydetails);
    // print(id);
//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.fulldetails_baseurl + ApiConstants.fulldetails_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": "978",
      "mode": "11",
      "comptype": id,
      "type_id": "1",
      "slftype": "1"
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
      final data = GrievanceFullDetails.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "true") {
          if (data.grievance != null && data.grievance!.length > 0) {
            grievanceFullDetails = data;
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
  
  
/* Container FileSelection(String? photo) {
  return Container(
    child: Image.asset(photo.contains(".jpg")),
  );
} */

}
