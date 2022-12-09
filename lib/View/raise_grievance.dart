
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/raise_grievance_response.dart';
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
    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text(
            "Grievance Types",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                    ), 
                    itemCount:_grievanceResponse?.rOW?.length , itemBuilder: ((context, index) {
                       final data = _grievanceResponse?.rOW?[index];
                      return GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Image.network("${data?.iURL}",
                          height: 50,
                          ),
                          
                          Text(
                            "${data?.cNAME}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    );
                    })),
              ),
             
            ],
          ),
          
      ),
       bottomSheet: SizedBox(
        height: 50,
         child: Card(
          
           color: Colors.transparent,
          
          margin: EdgeInsets.all(6.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rights Reserved@GHMC",
              style: TextStyle(
                color: Colors.white
              ),
              ),
              Text("Powered By CGG",
              style: TextStyle(
                color: Colors.white
              ),
              ),
            ],
      ),
         ),
       )  
      
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
        if (data.rOW != null) {
          _grievanceResponse = data;
        }
      });
      print(_grievanceResponse?.tag);
    } on DioError catch (e) {
      print(e);
    }
  }
}

      /* body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: _grievanceResponse?.rOW?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = _grievanceResponse?.rOW?[index];
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Column(
                        children: [
                          Image.network("${data?.iURL}",
                          height: 50,
                          ),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          Text(
                            "${data?.cNAME}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
       bottomSheet: Container(
        decoration: BoxDecoration(
         color: Colors.transparent
        ),
        padding: EdgeInsets.all(6.0),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Rights Reserved@GHMC",
            style: TextStyle(
              color: Colors.white
            ),
            ),
            Text("Powered By CGG",
            style: TextStyle(
              color: Colors.white
            ),
            ),
          ],
      ),
       )  */
      
  
 

  


