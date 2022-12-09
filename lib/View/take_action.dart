/* 
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'package:ghmc_officer/Model/takeaction_response.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/image_picker.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/providers/provider_notifiers.dart';

class ApiResponse extends StatefulWidget {
  const ApiResponse({super.key});

  @override
  State<ApiResponse> createState() => _ApiResponseState();
}

class _ApiResponseState extends State<ApiResponse> {
  TakeActionModel? takeActionModel;
  List<String> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Take Action",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.bg), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: selectedCountry,
              builder: (context, value, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(color: Colors.white),
                      child: DropdownButton(
                        hint: value == null
                            ? Text('Please Select Country')
                            : Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        items: items.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text("  $val"),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          print(" $val");
                          selectedCountry.value = val;
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.88,
                constraints: BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: TextField(
                    maxLines: null,
                    decoration: new InputDecoration.collapsed(
                        hintText: "Enter your Remarks",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            ImgPicker(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textButton(
                  text: "SUBMIT",
                  width: 120,
                  height: 50,
                  backgroundcolor: Colors.blue,
                  textcolor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    const url =
        "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getStatusType";
    final pload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "type_id": "1",
      "designation": "AMOH"
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);
      var len = _response.data.length;
      //print(_response.data.length);

      for (var i = 0; i < len; i++) {
        final data = TakeActionModel.fromJson(_response.data[i]);

        setState(() {
          if (data.status == "success") {
            takeActionModel = data;
            items.add(data.type.toString());
            // print(items);
          }
        });
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
 */
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:ghmc_officer/Model/takeaction_response.dart';
import 'package:ghmc_officer/Res/components/appbar.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/providers/provider_notifiers.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

import '../Res/components/textwidget.dart';

class ApiResponse extends StatefulWidget {
  const ApiResponse({super.key});

  @override
  State<ApiResponse> createState() => _ApiResponseState();
}

class _ApiResponseState extends State<ApiResponse> {
  File? _image;
  Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
    });
  }

  TakeActionModel? takeActionModel;
  List<String> items = [];
  final genderList = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              ReusableAppbar(
                  topPadding: 20,
                  screenWidth: 1,
                  screenHeight: 0.08,
                  bgColor: Colors.white,
                  appIcon: Icon(Icons.arrow_back),
                  title: "Take Action",
                  onPressed: (() {
                    Navigator.pop(context);
                  })),
              ValueListenableBuilder(
                valueListenable: selectedCountry,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.88,
                        decoration: BoxDecoration(color: Colors.white),
                        child: DropdownButton(
                          hint: value == null
                              ? Text('Please Select Country')
                              : Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          dropdownColor: Colors.white,
                          iconEnabledColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          items: items.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text("  $val"),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            print(" $val");
                            selectedCountry.value = val;
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.88,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: TextField(
                      maxLines: null,
                      decoration: new InputDecoration.collapsed(
                          hintText: "Enter your Remarks",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              _image != null
                  ? Image.file(
                      _image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed: (() {
                            showAlert("Add Photo");
                          }),
                          icon: Icon(Icons.camera_alt_outlined),
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.09,
              child: Card(
                color: Colors.transparent,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: Text("Submit")),
              ),
            ),
          ),
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
    const url =
        "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getStatusType";
    final pload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "type_id": "1",
      "designation": "AMOH"
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);
      var len = _response.data.length;
      //print(_response.data.length);

      for (var i = 0; i < len; i++) {
        final data = TakeActionModel.fromJson(_response.data[i]);

        setState(() {
          if (data.status == "success") {
            takeActionModel = data;
            items.add(data.type.toString());
            // print(items);
          }
        });
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  showAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 45, 88, 124),
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.white,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: userGender,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.white),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      userGender.value = value;
                      if (value == "Choose Document") {
                        getImage(ImageSource.gallery);
                       
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "Choose from Gallery") {
                        getImage(ImageSource.gallery);
                      } else if (value == "cancel") {
                        // Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    items: genderList,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  );
                },
              ),
            ],
          );
        });
    //showDialog
  } //

}