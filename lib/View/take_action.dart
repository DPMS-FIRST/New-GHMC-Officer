import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmc_officer/model/get_staff_response.dart';
import 'package:ghmc_officer/model/get_ward_response.dart';
import 'package:ghmc_officer/model/shared_model.dart';
import 'package:ghmc_officer/model/takeaction_idproof_res.dart';

import 'package:ghmc_officer/model/takeaction_response.dart';
import 'package:ghmc_officer/model/update_grievance_response.dart';

import 'package:ghmc_officer/res/components/appbar.dart';
import 'package:ghmc_officer/res/components/background_image.dart';
import 'package:ghmc_officer/res/components/border_textfield.dart';
import 'package:ghmc_officer/res/components/sharedpreference.dart';
import 'package:ghmc_officer/res/components/showalert.dart';

import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';

import 'package:ghmc_officer/res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/res/constants/providers/provider_notifiers.dart';
import 'package:ghmc_officer/res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/res/constants/text_constants/text_constants.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

import '../res/components/textwidget.dart';

class ApiResponse extends StatefulWidget {
  const ApiResponse({super.key});

  @override
  State<ApiResponse> createState() => _ApiResponseState();
}

class _ApiResponseState extends State<ApiResponse> {
  final _formKey = GlobalKey<FormState>();

  FocusNode mobilenofocusnode = new FocusNode();
  FocusNode emailidfocusnode = new FocusNode();
  FocusNode fineamountfocusnode = new FocusNode();
  FocusNode amountfocusnode = new FocusNode();
  FocusNode proofidfocusnode = new FocusNode();

  TextEditingController mobileno = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController fineamount = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController proofid = TextEditingController();

  bool enabledropdown = false;
  List RamkyItems = [];
  GetStaff? _getStaff;
  GetWard? _getWard;
  File? _image;

  Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
      final bytes = tempimg.readAsBytesSync();
      String base64Image = "" + base64Encode(bytes);

      print("img_pan : $base64Image");
    });
  }

  TakeActionModel? takeActionModel;
  UpdateGrievanceResponse? _updateGrievanceResponse;
  TakeActionIdProofRes? _actionIdProofRes;
  List<String> items = [];
  List<String> warditems = [];
  List<String> idproofs = ["ADHAR"];
  final navigatorKey = GlobalKey<NavigatorState>();
  final imagePickingOptions = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            TextConstants.take_action,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: BorderTextfield(
                      horizantalpadding: 10.0,
                      verticalpadding: 4.0,
                      containerheight: 0.05,
                      containerwidth: 0.9,
                      textAlign: TextAlign.center,
                      maxlines: 10,
                      enabletext: false,
                      hinttext: TextConstants.take_action_citizen,
                      hinttextcolor: Colors.black,
                      contentpadding: 5.0,
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: takeactionIdproofsDropdown,
                      builder: ((context, value, child) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.88,
                              decoration: BoxDecoration(color: Colors.white),
                              child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  // value: selectedCountry.value,
                                  hint: value == null
                                      ? Text('Please Select ')
                                      : Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  items: idproofs.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text("$val"),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    takeactionIdproofsDropdown.value = val;
                                  }),
                            ),
                          ),
                        );
                      })),
                  BorderTextfield(
                    horizantalpadding: 4.0,
                    verticalpadding: 4.0,
                    containerheight: 0.05,
                    containerwidth: 0.9,
                    controller: proofid,
                    focusNode: proofidfocusnode,
                    hinttext: TextConstants.take_action_Proofid,
                    hinttextcolor: Colors.grey,
                    contentpadding: 5.0,
                    textAlign: TextAlign.start,
                  ),
                  BorderTextfield(
                    horizantalpadding: 4.0,
                    verticalpadding: 4.0,
                    containerheight: 0.05,
                    containerwidth: 0.9,
                    controller: mobileno,
                    maxlines: 10,
                    focusNode: mobilenofocusnode,
                    hinttext: TextConstants.take_action_mobileno,
                    hinttextcolor: Colors.grey,
                    contentpadding: 5.0,
                    textAlign: TextAlign.start,
                  ),
                  BorderTextfield(
                    horizantalpadding: 10.0,
                    verticalpadding: 4.0,
                    containerheight: 0.05,
                    containerwidth: 0.9,
                    controller: emailid,
                    maxlines: 10,
                    focusNode: emailidfocusnode,
                    hinttext: TextConstants.take_action_emailid,
                    hinttextcolor: Colors.grey,
                    contentpadding: 5.0,
                    textAlign: TextAlign.start,
                  ),
                  BorderTextfield(
                    horizantalpadding: 10.0,
                    verticalpadding: 4.0,
                    containerheight: 0.05,
                    containerwidth: 0.9,
                    controller: fineamount,
                    maxlines: 10,
                    focusNode: fineamountfocusnode,
                    hinttext: TextConstants.take_action_fine_amount,
                    hinttextcolor: Colors.grey,
                    contentpadding: 5.0,
                    textAlign: TextAlign.start,
                  ),
                  BorderTextfield(
                    horizantalpadding: 10.0,
                    verticalpadding: 4.0,
                    containerheight: 0.15,
                    containerwidth: 0.9,
                    controller: amount,
                    maxlines: 10,
                    focusNode: amountfocusnode,
                    hinttext: TextConstants.take_action_amount,
                    hinttextcolor: Colors.grey,
                    contentpadding: 5.0,
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Card(
                      color: Colors.transparent,
                      child: ElevatedButton(
                          onPressed: () {
                           Alerts.showAlertDialog(context, "Thanks for updating", Title: "Alert", onpressed: (){});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text("Submit")),
                    ),
                  ),
                ],
              ),
            )
          ],
        )); /* SizedBox(
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
                    takeActionTypes.value = "   select";
                  })),
              ValueListenableBuilder(
                valueListenable: takeActionTypes,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.88,
                        decoration: BoxDecoration(color: Colors.white),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            // value: selectedCountry.value,
                            hint: value == null
                                ? Text('Please Select ')
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
                              takeActionTypes.value = "   $val";

                              if (val == "Forward to Ramky") {
                                RamkyItems = ["select", "Claimed", "Unclaimed"];
                                setState(() {
                                  enabledropdown = true;
                                  ramkyvalues.value = "   select";
                                });
                              } else if (val == "Forward to Lower Staff") {
                                getStaffshowAlert("${_getStaff?.tag}");
                                setState(() {
                                  enabledropdown = false;
                                });
                              } else if (val == "Forward to another ward") {
                                RamkyItems = warditems;
                                setState(() {
                                  enabledropdown = true;
                                  ramkyvalues.value = "   select";
                                });
                              } else {
                                setState(() {
                                  enabledropdown = false;
                                });
                              }
                            }),
                      ),
                    ),
                  );
                },
              ),
              enabledropdown ? subDropdown() : Text(""),
              Center(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.88,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          /* validator: ((value) {
                            if (value!.isEmpty) {
                              return "Please";
                            }
                          }), */
                          controller: _controller,
                          maxLines: null,
                          decoration: new InputDecoration.collapsed(
                              hintText: "Enter Your Remarks",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              _image != null
                  ? GestureDetector(
                      onTap: (() {
                        showAlert("Add Photo");
                      }),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
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
              height: MediaQuery.of(context).size.height * 0.07,
              child: Card(
                color: Colors.transparent,
                child: ElevatedButton(
                    onPressed: () {
                      if (validate(takeActionTypes.value.toString())) {
                        showToast("Please Select Complaint Status");
                      } else if (validate(ramkyvalues.value.toString())) {
                        if (enabledropdown == true) {
                          showToast("Please Select sub Complaint Status");
                        } else {
                          getStaffshowAlert(
                              _updateGrievanceResponse!.compid.toString());
                        }
                      }
                      if (validateOfficer(_controller.text)) {
                        showToast("Please enter your remarks");
                      } else if (validateOfficer(
                          takeActionTypes.value.toString())) {
                        showToast("Please select Image");
                      } else {
                        getStaffshowAlert(
                            _updateGrievanceResponse!.compid.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: Text("Submit")),
              ),
            ),
          ),
        ],
      ),
    ); */
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
    ForwarToLowerStaffDetails();
    GetWardDetails();
    updateGrievanceDetails();
    getIdproofDetails();
  }

  getIdproofDetails() async {
    const url = ApiConstants.baseurl + ApiConstants.takeAction_idproof_endpoint;
    final _dioobject = Dio();
    try {
      final response = await _dioobject.get(url);
      final data = TakeActionIdProofRes.fromJson(response.data);
      if (data.status == "true") {
        setState(() {
          _actionIdProofRes = data;
        });
        var idprooflen = _actionIdProofRes?.data?.length ?? 0;
        // print(ward_len);

        for (var i = 0; i < idprooflen; i++) {
          // print(_getWard!.data![i].ward);
          idproofs.add(_actionIdProofRes!.data![i].name.toString());
        }
      } else {
        print("");
      }
    } on DioError catch (e) {
      print(e);
    }
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
            EasyLoading.dismiss();
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

  //forward to lower staff
  ForwarToLowerStaffDetails() async {
    const url =
        "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getLowerStaff?empId=978";

    final _dioObject = Dio();
    try {
      final _response =
          await _dioObject.get(url, queryParameters: {"empId": "978"});
      final data = GetStaff.fromJson(_response.data);
      // print(data.tag);
      setState(() {
        _getStaff = data;
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  GetWardDetails() async {
    const url = ApiConstants.baseurl + ApiConstants.get_ward_endpoint;

    final _dioObject = Dio();
    final getward_payload = {"userid": "cgg@ghmc", "password": "ghmc@cgg@2018"};

    try {
      final _response = await _dioObject.post(url, data: getward_payload);
      final data = GetWard.fromJson(_response.data);
      //
      //print(data.tag);
      if (data.status == "true") {
        EasyLoading.dismiss();
        setState(() {
          _getWard = data;
        });
        print(_getWard?.tag);

        var ward_len = _getWard?.data?.length ?? 0;
        // print(ward_len);

        for (var i = 0; i < ward_len; i++) {
          // print(_getWard!.data![i].ward);
          warditems.add(_getWard!.data![i].ward.toString());
        }
      }
      // print(warditems);
    } on DioError catch (e) {
      print(e);
    }
  }

  updateGrievanceDetails() async {
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    const url = ApiConstants.baseurl + ApiConstants.update_grievance_end_point;
    final payload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "type_id": "1",
      "mobileno":
          "8008554962-Dr.K.S.Ravi-{\"userid\":\"cgg@ghmc\",\"password\":\"ghmc@cgg@2018\",\"type_id\":\"1\"}",
      "updatedstatus": "3",
      "compId": compid,
      "remarks": "test",
      "latlon": "17.4366254,78.3608523",
      "deviceid": "5ed6cd80c2bf361b",
      "no_of_trips": "",
      "total_net_weight": "",
      "trader_name": " ",
      "id_proof_no": "",
      "nmos_mobile_no": "",
      "email": "",
      "fine_amount": "",
      "source": "11",
      "vehicleNo": "",
      "PhotoType": "PhotoType",
      "claimant_status": "",
      "lower_staff_id": ""
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: payload);
      final data = UpdateGrievanceResponse.fromJson(_response.data);

      setState(() {
        EasyLoading.dismiss();
        _updateGrievanceResponse = data;
      });

      //  print(" update grievance data ${_updateGrievanceResponse?.status}");
      //
    } on DioError catch (e) {
      print(e);
    }
  }

  getStaffshowAlert(String message, {String text = ""}) {
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
            actions: [
              TextButton(
                onPressed: () {
                  if (message == _getStaff?.tag) {
                    Navigator.pop(context);
                  } else if (message == _updateGrievanceResponse?.compid) {
                    if (_updateGrievanceResponse?.status == "False") {
                      Navigator.pushNamed(context, AppRoutes.takeaction);
                    } else if (_updateGrievanceResponse?.status == "True") {
                      Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                    }
                  }
                },
                child: Text(
                  TextConstants.ok,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        }); //showDialog
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
                valueListenable: imageOptions,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.white),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageOptions.value = value;
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
                    items: imagePickingOptions,
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
  }

  subDropdown() {
    return ValueListenableBuilder(
      valueListenable: ramkyvalues,
      builder: (context, value, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(color: Colors.white),
              child: DropdownButton(
                  underline: Container(color: Colors.transparent),
                  hint: value == null
                      ? Text('Please Select ')
                      : Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  dropdownColor: Colors.white,
                  iconEnabledColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  items: RamkyItems.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text("  $val"),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    print(" $val");
                    ramkyvalues.value = "   $val";
                  }),
            ),
          ),
        );
      },
    );
  }

  validate(String remarks) {
    if (remarks.isEmpty) {
      return true;
    } else if (remarks == "   select") {
      return true;
    } else {
      return false;
    }
  }

  validateOfficer(String res) {
    if (res.isEmpty) {
      return true;
    } else if (res.trimLeft() == "Resolved by Officer") {
      if (_image == null) {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
