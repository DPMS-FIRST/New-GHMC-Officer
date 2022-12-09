import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/full_details_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/searchbar.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

import 'package:ghmc_officer/View/grievance_history.dart';
import 'package:ghmc_officer/View/image_view.dart';

class FullGrievanceDetails extends StatefulWidget {
  const FullGrievanceDetails({super.key});

  @override
  State<FullGrievanceDetails> createState() => _FullGrievanceDetailsState();
}

class _FullGrievanceDetailsState extends State<FullGrievanceDetails> {
  GrievanceFullDetails? grievanceFullDetails;
  // String? _backgroundImage;
  //  String? _backgroundImage2;
  //   String? _backgroundImage3;
    String? image1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TextConstants.full_grievance_details,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath:ImageConstants.bg),
          Column(
            children: [
              ReusableSearchbar(
                  bgColor: Colors.white, 
                  screenHeight: 0.08, 
                  searchIcon: Icon(Icons.search), 
                  topPadding: 20.0, 
                  onPressed: () {  }, 
                  screenWidth: 1,),
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
                                        TextConstants.id,
                                        details?.id,
                                      ),
                                      RowComponent(
                                        TextConstants.type,
                                        details?.type,
                                      ),
                                      RowComponent(
                                        TextConstants.time_stamp,
                                        details?.timestamp,
                                      ),
                                      RowComponent(
                                        TextConstants.status,
                                        details?.status,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
          
                                        children: [
                                        setImage( 
                                        details?.photo,
                                        onTap: () {
                                        if(details!.photo!.contains(".")){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: details.photo),));
                                        }
                                        else
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: ImageConstants.no_uploaded))); 
                                        }
                                        },
                                        ),
                                        setImage(
                                        details?.photo2,
                                        onTap: () {
                                          if(details!.photo2!.contains(".")){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: details.photo2),));
                                        }
                                        else
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: ImageConstants.no_uploaded))); 
                                        }
                                        },
                                        ),
                                        setImage(
                                        details?.photo3,
                                        onTap: () {
                                          if(details!.photo3!.contains(".")){
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: details.photo3),));
                                        }
                                        else
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder:(context) => ImageViewPage(img: ImageConstants.no_uploaded))); 
                                        }
                                        },
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
  
setImage(_backgroundImage, {void Function()? onTap}) {

     if(_backgroundImage.contains('.pdf'))
     {
        return GestureDetector(
          onTap:onTap,
          child: Container(
            padding: EdgeInsets.only(top:10.0),
            child: Image.asset(ImageConstants.viewpdf,
            width: 100,
            height: 80,
            ),
          ),
        );
     }
     else if(_backgroundImage.contains('.jpg') || _backgroundImage.contains('.png') || _backgroundImage.contains('.jpeg'))
     {
      return GestureDetector(
        onTap: onTap,
        child: Container(
           padding: EdgeInsets.only(top:10.0),
            child: Image.asset(ImageConstants.viewimage,
             width: 100,
            height: 90,
            ),
          ),
      );
     }
     else{
      return GestureDetector(
        onTap: onTap,
        child: Container(
           padding: EdgeInsets.only(top:10.0),
            child: Image.asset(ImageConstants.no_uploaded,
             width: 100,
            height: 90,
            ),
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
     // print(response.data);
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

}