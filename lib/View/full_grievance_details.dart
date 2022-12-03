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
   String? _backgroundImage2;
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
                                        mainAxisAlignment: MainAxisAlignment.center,
          
                                        children: [
                                             setImage(
                                        _backgroundImage = details?.photo
                                        ),
                                        setImage(
                                        _backgroundImage3 = details?.photo2
                                        ),
                                        setImage(
                                        _backgroundImage3 = details?.photo3
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
  
setImage(_backgroundImage) {

     if(_backgroundImage.toString().contains('.pdf'))
     {
        _backgroundImage = "assets/viewpdf.png";
        return Container(
          padding: EdgeInsets.only(top:10.0),
          child: Image.asset("${_backgroundImage}",
          width: 100,
          height: 80,
          ),
        );
     }
     else{
      _backgroundImage = "assets/viewimage.png";
      return Container(
         padding: EdgeInsets.only(top:10.0),
          child: Image.asset("${_backgroundImage}",
           width: 100,
          height: 90,
          ),
        );
     }
     

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
    fetchDetails();
  }

  fetchDetails() async {
    var compid = await SharedPreferencesClass()
       .readTheData(PreferenceConstants.fulldetails);
    var modeid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.userdetails);
    var uid = await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
     var typeid = await SharedPreferencesClass(). readTheData(PreferenceConstants.typeid);
     var slftype =
        await SharedPreferencesClass().readTheData(PreferenceConstants.totalid);
    // var userid = await SharedPreferencesClass().readTheData(PreferenceConstants.fulldetails);
    //   var id = await SharedPreferencesClass().readTheData( PreferenceConstants.historydetails);
    // print(id);
//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.fulldetails_baseurl + ApiConstants.fulldetails_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": uid,
      "mode": modeid,
      "comptype": compid,
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
      final data = GrievanceFullDetails.fromJson(response.data);
      print(response.data);
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
