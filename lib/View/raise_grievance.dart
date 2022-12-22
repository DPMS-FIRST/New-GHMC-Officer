
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/raise_grievance_response.dart';
import 'package:ghmc_officer/Res/components/appbar.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';



class RaiseGrievance extends StatefulWidget {
  const RaiseGrievance({super.key});

  @override
  State<RaiseGrievance> createState() => _RaiseGrievanceState();
}

class _RaiseGrievanceState extends State<RaiseGrievance> {
  raiseGrievanceResponse? _grievanceResponse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          BgImage(imgPath: ImageConstants.bg),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ReusableAppbar(
                    topPadding: 20,
                    screenWidth: 1,
                    screenHeight: 0.09,
                    bgColor: Colors.white,
                    appIcon: Icon(Icons.arrow_back),
                    title: "Grievance Types",
                    onPressed: (() {
                      Navigator.pop(context);
                    })),
                Expanded(
                  child: Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                      ),
                      itemCount: _grievanceResponse?.rOW?.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: (() {
                            
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                        "${_grievanceResponse?.rOW?[index].iURL}")),
                                Flexible(
                                    child: Center(
                                        child: Text(
                                  "${_grievanceResponse?.rOW?[index].cNAME}",
                                  style: TextStyle(color: Colors.white),
                                ))),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
           Expanded(
            flex: 1,
             child: Align(
              alignment: Alignment.bottomLeft,
              child:Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    TextWidget(text: "Rights Reserved@GHMC", left: 0, right: 0, top: 0, bottom: 0,textcolor: Colors.white,),
                    TextWidget(text: "Powerd By CGG", left: 0, right: 0, top: 0, bottom: 0,textcolor: Colors.white,)
                    
           
                  ],),
                 
                ),
              ),
             ),
           )
           
           
        ],
      ),
    ); 
  }

  @override
  void initState() {
    
    super.initState();
    raiseGrievanceDetails();
  }

  raiseGrievanceDetails() async {
    final raise_grievance_url = ApiConstants.raise_grievance_baseurl +
        ApiConstants.raise_grievance_endpoint;
    final raise_grievance_payload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018"
    };
    final dio_obj = Dio();
    try {
      final raise_grievance_response = await dio_obj.post(raise_grievance_url,
          data: raise_grievance_payload);
      // print(raise_grievance_response.data);
      final data =
          raiseGrievanceResponse.fromJson(raise_grievance_response.data);
      setState(() {
        _grievanceResponse = data;
      });
      print(_grievanceResponse?.tag);
    } on DioError catch (e) {
      print(e);
    }
  }
}
