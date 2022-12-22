import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghmc_officer/Model/check_status_response.dart';
import 'package:ghmc_officer/Model/grievance_details_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

class GrievanceDetails extends StatefulWidget {
  const GrievanceDetails({super.key});

  @override
  State<GrievanceDetails> createState() => _GrievanceDetailsState();
}

class _GrievanceDetailsState extends State<GrievanceDetails> {
  GrievanceDetailsResponse? _grievanceDetailsResponse;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
         Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowComponent(
                              TextConstants.check_status_id,_grievanceDetailsResponse?.grievance?[0].id ),
                         
                          
                        ],
                      )),
        
        
      ],
    );
  }

  checkStatusDetails() async {
    final check_status_compId =
        await SharedPreferencesClass().readTheData(PreferenceConstants.check_status_id);

    final mobile=await SharedPreferencesClass().readTheData(PreferenceConstants.mobileno);

    final grievance_details_url =
        ApiConstants.check_status_grievance_details_baseurl +
            ApiConstants.check_status_grievance_details_endpoint;
    final grievance_details_payload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "MobileNo": mobile,
      "CompId": check_status_compId
    };
    final dio_obj = Dio();
    try {
      final grievance_details_response = await dio_obj
          .post(grievance_details_url, data: grievance_details_payload);
      // print(check_status_response.data);

      final data =
          GrievanceDetailsResponse.fromJson(grievance_details_response.data);

      if (data.status == "success") {
        setState(() {
          _grievanceDetailsResponse = data;
        });
      }
      print(_grievanceDetailsResponse?.grievance?[0].assignedto);

      // print(d);
    } on DioError catch (e) {
      print(e);
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatusDetails();
  }
}
