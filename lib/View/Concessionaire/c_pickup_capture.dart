import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmc_officer/model/concessionaire_pickup_capture_bind_plantname_req.dart';
import 'package:ghmc_officer/model/concessionaire_pickup_capture_bindplantname_res.dart';

import 'package:ghmc_officer/model/conecssionare_pickup_capture_get_vehicletypes_res.dart';

import 'package:ghmc_officer/res/components/background_image.dart';
import 'package:ghmc_officer/res/components/button.dart';
import 'package:ghmc_officer/res/components/textwidget.dart';
import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/app_constants.dart';


import 'package:ghmc_officer/res/constants/providers/provider_notifiers.dart';
import 'package:ghmc_officer/res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/res/constants/text_constants/text_constants.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

class ConcessionairePickupCapture extends StatefulWidget {
  const ConcessionairePickupCapture({super.key});

  @override
  State<ConcessionairePickupCapture> createState() =>
      _ConcessionairePickupCaptureState();
}

class _ConcessionairePickupCaptureState
    extends State<ConcessionairePickupCapture> {
  ConcessionairePickupCaptureBindPlantNameRes?
      _concessionairePickupCaptureBindPlantNameRes;

  ConcessionairePickupCaptureGetVehicleTypesRes?
      _concessionairePickupCaptureGetVehicleTypesRes;
  TextEditingController drivername = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  List vehicleNo = ["Select Vehicle No"];
  List<String> plantnames = ["Select Vehicle No"];
  List<String> vehicletypes = ["Select Vehicle Type"];
  File? _image;
  Future getImage(ImageSource type) async {
    final img = await ImagePicker().pickImage(source: type);
    if (img == null) return;
    final tempimg = File(img.path);
    setState(() {
      this._image = tempimg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              // EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
              vehicleNumbersDropdown.value = "Select Vehicle No";
              vehicletypesdropdown.value = "Select Vehicle Type";
              bindplantnamesdropdown.value = " Select Plant Name";
            })
            //() => Navigator.of(context).pop(),
            ),
        title: Center(
          child: Text(
            "Concessionaire Pickup Capture",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        SingleChildScrollView(
          child: Column(
            children: [
               RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_ticketID,
                  Constants.ticktetitemslist?.tICKETID),
              RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_locatio,
                  Constants.ticktetitemslist?.lOCATION),
              RowComponent(
                  TextConstants.concessionaire_pickup_capturelist_Landmark,
                  Constants.ticktetitemslist?.lANDMARK),
              RowComponent(TextConstants.concessionaire_pickup_capturelist_date,
                  Constants.ticktetitemslist?.cREATEDDATE),
              ValueListenableBuilder(
                valueListenable: vehicleNumbersDropdown,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            hint: value == null
                                ? Text('Please Select ')
                                : Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            items: vehicleNo.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text("  $val"),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              print(" $val");
                              vehicleNumbersDropdown.value = "   $val";
                            }),
                      ),
                    ),
                  );
                },
              ),
              RowComponent(
                  TextConstants.concessionaire_pickup_capture_beforepickup, ""),
              _image != null
                  ? GestureDetector(
                      onTap: (() {
                        ImageOptionAlert("Add Photo");
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
                            ImageOptionAlert("Add Photo");
                          }),
                          icon: Icon(Icons.camera_alt_outlined),
                          color: Colors.white,
                        ),
                      ),
                    ),
              ValueListenableBuilder(
                valueListenable: bindplantnamesdropdown,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            hint: value == null
                                ? Text('Please Select ')
                                : Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            items: plantnames.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text("  $val"),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              print(" $val");
                              bindplantnamesdropdown.value = "   $val";
                            }),
                      ),
                    ),
                  );
                },
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: myFocusNode1,
                        controller: drivername,
                        style: const TextStyle(color: Colors.white),
                        keyboardType:TextInputType.text,
                        cursorColor: Color.fromARGB(255, 33, 184, 166),
                        decoration: InputDecoration(
                          //to hide maxlength
                          counterText: '',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 33, 184, 166),
                          )),

                          labelStyle: TextStyle(
                              color: myFocusNode1.hasFocus
                                  ? Color.fromARGB(255, 33, 184, 166)
                                  : Colors.white,
                              fontSize: 18.0),
                          labelText: TextConstants
                              .concessionaire_pickup_capture_drivername,
                        ),
                      ),
                      TextFormField(
                        focusNode: myFocusNode2,
                        controller: mobilenumber,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        cursorColor: Color.fromARGB(255, 33, 184, 166),
                        decoration: InputDecoration(
                          //to hide maxlength
                          counterText: '',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 33, 184, 166),
                          )),

                          labelStyle: TextStyle(
                              color: myFocusNode2.hasFocus
                                  ? Color.fromARGB(255, 33, 184, 166)
                                  : Colors.white,
                              fontSize: 18.0),
                          labelText: TextConstants
                              .concessionaire_pickup_capture_mobileno,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:  15.0),
                child: ValueListenableBuilder(
                  valueListenable: vehicletypesdropdown,
                  builder: (context, value, child) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.95,
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
                              items: vehicletypes.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text("  $val"),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                print(" $val");
                                vehicletypesdropdown.value = "   $val";
                              }),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  color: Colors.transparent,
                  child: textButton(
                    text: TextConstants.concessionaire_pickup_capture_submit,
                    textcolor: Colors.white,
                    onPressed: () {
                      if (validate("${vehicleNumbersDropdown.value}")) {
                        showToast("Please select vehicle No");
                       
                      }else if (validate("${_image?.path}")) {
                        
                        showToast("Please select image");
                      }
                       else if (validate("${bindplantnamesdropdown.value}")) {
                       
                        showToast("Please select plant name");
                      } else if (validate("${drivername.text}")) {
                        print("kappa");
                        showToast("Please enter driver name");
                      } else if (validate("${mobilenumber.text}")) {
                        showToast("Please enter mobile number");
                      } else if (validate("${mobilenumber.text}")) {
                        showToast("Please enter valid mobile number");
                      } else if (validate("${vehicletypesdropdown.value}")) {
                        showToast("Please select plant name");
                      }

                      //print(vehicleNumbersDropdown.value);

                      //Navigator.pushNamed(context, AppRoutes.takeaction);
                    },
                  ),
                ),
              ),
              
            ],
          ),
        )
      ]),
    );
  }

  RowComponent(var data, var val) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                textcolor: Colors.white,
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
                textcolor: Colors.white,
              ))
        ],
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  validate(String remarks) {
    if (remarks == "Select Vehicle No") {
      print(remarks);
      return true;
    } else if (remarks == null) {
      print(remarks);
      return true;
    }
    else if (remarks == "Select Plant Name") {
      print(remarks);
      return true;
    } else if (remarks == '') {
      return true;
    } else if (remarks.length < 10) {
      print("remarks :$remarks");
      return true;
    } else if (remarks == "Select Vehicle Type") {
      return true;
    } else {
      return false;
    }
  }

  ImageOptionAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.black,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: imageOptions,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.black),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageOptions.value = value;
                      if (value == "Choose from Library") {
                        getImage(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "cancel") {
                        // Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    items: Constants.imagePickingOptions,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("item list ${Constants.ticktetitemslist?.tICKETID}");
  

    var VehicleNolen = Constants.ticktetitemslist?.listVehicles?.length ?? 0;
    for (var i = 0; i < VehicleNolen; i++) {
      vehicleNo.add(Constants.ticktetitemslist?.listVehicles?[i].vEHICLENO);
    }

    GetPlantIds();
    Getvehicletypes();
  }

  GetPlantIds() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants
            .concessionaire_incharge_pickup_capture_bind_plant_name_endpoint;
    ConcessionairePickupCaptureBindPlantNameReq
        concessionairePickupCaptureBindPlantNameReq =
        new ConcessionairePickupCaptureBindPlantNameReq();
    concessionairePickupCaptureBindPlantNameReq.uSERID = "cgg@ghmc";
    concessionairePickupCaptureBindPlantNameReq.pASSWORD = "ghmc@cgg@2018";
    final payload = concessionairePickupCaptureBindPlantNameReq.toJson();
    final _dioOnject = Dio();
    final response = await _dioOnject.post(url, data: payload);

    final data =
        ConcessionairePickupCaptureBindPlantNameRes.fromJson(response.data);
    if (data.sTATUSCODE == "200") {
      setState(() {
        _concessionairePickupCaptureBindPlantNameRes = data;
        if (_concessionairePickupCaptureBindPlantNameRes?.pLANTDTLS != null) {
          var plantnamelistlen =
              _concessionairePickupCaptureBindPlantNameRes?.pLANTDTLS?.length ??
                  0;
          for (var i = 0; i < plantnamelistlen; i++) {
            plantnames.add(
                "${_concessionairePickupCaptureBindPlantNameRes?.pLANTDTLS?[i].pLANTNAME}");
          }
        }
      });
    } else if (data.sTATUSCODE == "400") {
      print("${data.sTATUSMESSAGE}");
    } else if (data.sTATUSCODE == "600") {}
  }

  Getvehicletypes() async {
    final url = ApiConstants.concessionaire_baseurl +
        ApiConstants.concessionaire_incharge_pickup_capture_vehicletypes;

    final _dioOnject = Dio();
    final response = await _dioOnject.get(url);
    print(response.data);
    final data =
        ConcessionairePickupCaptureGetVehicleTypesRes.fromJson(response.data);
    if (data.sTATUSCODE == "200") {
      setState(() {
        _concessionairePickupCaptureGetVehicleTypesRes = data;
        if (_concessionairePickupCaptureGetVehicleTypesRes?.vEHICLELIST !=
            null) {
          var vehicletypeslen = _concessionairePickupCaptureGetVehicleTypesRes
                  ?.vEHICLELIST?.length ??
              0;
          for (var i = 0; i < vehicletypeslen; i++) {
            vehicletypes.add(
                "${_concessionairePickupCaptureGetVehicleTypesRes?.vEHICLELIST?[i].vEHICLETYPE}");
          }
        }
        print(vehicletypes);
      });
    } else if (data.sTATUSCODE == "400") {
      print("${data.sTATUSMESSAGE}");
    } else if (data.sTATUSCODE == "600") {}
  }
}
