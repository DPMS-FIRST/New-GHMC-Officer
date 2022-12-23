import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmc_officer/Model/new_complaint_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/imagepicker.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/providers/provider_notifiers.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/View/googlemaps.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

class NewComplaint extends StatefulWidget {
  const NewComplaint({super.key});

  @override
  State<NewComplaint> createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  //BestTutorSite _site = BestTutorSite.javatpoint;
  NewComplaintResponse? newComplaintResponse;
  //File? _image;

  /* Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
    });
  } */

  XFile imageData1 = XFile("");
  XFile imageData2 = XFile("");
  XFile imageData3 = XFile("");

  TextEditingController nameController = TextEditingController();
  TextEditingController LandmarkController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController description = TextEditingController();
  String? gender;
  List type = [];

  final locationList = ["Use Current Location", "Locate on Map"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () async{
                EasyLoading.show();
                Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed:(() {
               Navigator.of(context).pop();
               complaint.value="select";
              
            }) 
            //() => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "New Complaint",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.bg),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  //Location(),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: ValueListenableBuilder(
                      valueListenable: location,
                      builder: (context, value, child) {
                        return RadioGroup<String>.builder(
                          horizontalAlignment: MainAxisAlignment.center,
                          textStyle: TextStyle(color: Colors.white),
                          
                          fillColor: Colors.black,
                          activeColor: Colors.black,
                          direction: Axis.horizontal,
                          groupValue: value ?? "",
                          onChanged: (value) {
                            location.value = value;
                            Navigator.push(context, MaterialPageRoute(builder:(context) => const MapSample()));
                          },
                          items: locationList,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        );
                      },
                    ),
                  ),
                  //name
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 3.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  //dropdown
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 2.0),
                    child: ValueListenableBuilder(
                      valueListenable: newcomplaintdropdown,
                      builder: (context, value, child) {
                        return Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              hint: value == null
                                  ? Text('Select')
                                  : Text(
                                      " " + value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              items: type.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text("  $val"),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                newcomplaintdropdown.value = val;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //Landmark
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 2.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: LandmarkController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Landmark",
                              hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  //Enter your Description

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 4.0),
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.15,
                      constraints: BoxConstraints(maxHeight: 75.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: TextField(
                            controller: description,
                            maxLines: null,
                            decoration: new InputDecoration.collapsed(
                                border: InputBorder.none,
                                hintText: "Enter your Description",
                                hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //mobile
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 2.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contact Number",
                              hintStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  //image pickers
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ImgPickerCamera(
                            callbackValue: (imageData) {
                              imageData1 = imageData;  
                            },
                          ),
                          ImgPickerCamera(
                            callbackValue: (imageData) {
                              imageData2 = imageData;
                            },
                          ),
                          ImgPickerCamera(
                            callbackValue: (imageData) {
                              imageData3 = imageData;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),

                  //submit
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if(newcomplaintdropdown.value=="Select" || newcomplaintdropdown.value=="select"){
                            showToast("Please Select Complaint Status");
                          }
                          else if(description.text.isEmpty)
                          {
                            showToast("Please enter description");
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rights Reserved @ GHMC",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Powered By CGG",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ));
  }
   void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0,
        );
  }

  @override
  void initState() {
    super.initState();
    newComplaintDetails();
  }

  newComplaintDetails() async {
    var gid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.grievance_type);
    var emp_name =
        await SharedPreferencesClass().readTheData(PreferenceConstants.name);
    var mobile_no = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    //creating request url with base url and endpoint
    //
    setState(() {
      nameController.text = emp_name;
      mobileController.text = mobile_no;
    });
    const requesturl =
        ApiConstants.baseurl + ApiConstants.new_complaint_endpoint;

    var requestPayload = {
      "Latitude": "17.436617",
      "Longitude": "78.3608504",
      "gid": gid,
      "password": "ghmc@cgg@2018",
      "userid": "cgg@ghmc"
    };

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );
      var len = response.data.length;

      //converting response from String to json
      for (var i = 0; i < len; i++) {
        final data = NewComplaintResponse.fromJson(response.data[i]);

        setState(() {
          if (data.status == "success") {
            EasyLoading.dismiss();
            newComplaintResponse = data;
          }
          type.add(newComplaintResponse?.type);
        });
        //  print(type);
      }
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
