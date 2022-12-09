import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/login_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';


class LoginShared extends StatefulWidget {
  const LoginShared({super.key});

  @override
  State<LoginShared> createState() => _LoginSharedState();
}

class _LoginSharedState extends State<LoginShared> {
  TextEditingController number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  bool _isLoading = false;
  ghmc_login? ResponseData;
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.bg)),
        ),
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          color: Color.fromARGB(255, 58, 71, 77),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      focusNode: myFocusNode,
                      controller: number,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      cursorColor: Color.fromRGBO(33, 121, 110, 1),
                      decoration: InputDecoration(
                        //to hide maxlength

                        counterText: '',
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 33, 121, 110),
                        )),

                        labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Color.fromRGBO(33, 121, 110, 1)
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                        labelText: TextConstants.mobile_no,
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return TextConstants.mobile_validation;
                        } else if (value.length < 10) {
                          return TextConstants.mobile_count_validation;
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                          textStyle: TextStyle(fontSize: 24),
                          //minimumSize: Size.fromHeight(55),
                          //shape: StadiumBorder(),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //print("onpressed");
                            fetchLoginDetailsFromApi();
                            if (_isLoading) return;
                            setState(() {
                              _isLoading = true;
                            });

                            await Future.delayed(Duration(seconds: 1));

                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        child: _isLoading
                            ? Container(
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Loading...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Text(
                                TextConstants.login,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }

  @override
  void initState() {
  
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
   readsharedprefData();
  }

  void fetchLoginDetailsFromApi() async {
    
    final requestUrl =
        ApiConstants.login_baseurl + ApiConstants.login_endpoint;

    final _dioObject = Dio();

    //Response
    try {
      final _response = await _dioObject
          .get(requestUrl, queryParameters: {"MOBILE_NO": number.text});

      final data = ghmc_login.fromJson(_response.data);

      if (_response.data != null) {
        setState(() {
          this.ResponseData = data;
        });
        print(_response.data);
        // print(ResponseData.status);

        if (ResponseData?.status == 'M') {
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.mobileno, ResponseData?.mOBILENO);

          SharedPreferencesClass().writeTheData(PreferenceConstants.mpin, ResponseData?.mpin);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.category, ResponseData?.cATEGORY);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.designation, ResponseData?.dESIGNATION);
          
          SharedPreferencesClass().writeTheData(PreferenceConstants.uid, ResponseData?.eMPD);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.name, ResponseData?.eMPNAME);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.message, ResponseData?.message);

          SharedPreferencesClass().writeTheData(PreferenceConstants.status, ResponseData?.status);

          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.tokenId, ResponseData?.tOKENID);

          SharedPreferencesClass().writeTheData(PreferenceConstants.typeid, ResponseData?.tYPEID);

        Navigator.pushNamed(context, AppRoutes.mpin);
        } else if (ResponseData?.status == 'O') {
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.mobileno, ResponseData?.mOBILENO);
          print("otp from Api ${ResponseData?.otp}");
          SharedPreferencesClass().writeTheData(PreferenceConstants.otp, ResponseData?.otp);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.category, ResponseData?.cATEGORY);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.designation, ResponseData?.dESIGNATION);
          SharedPreferencesClass().writeTheData(PreferenceConstants.empd, ResponseData?.eMPD);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.name, ResponseData?.eMPNAME);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.message, ResponseData?.message);
          SharedPreferencesClass().writeTheData(PreferenceConstants.status, ResponseData?.status);
          SharedPreferencesClass()
              .writeTheData(PreferenceConstants.tokenId, ResponseData?.tOKENID);
          SharedPreferencesClass().writeTheData(PreferenceConstants.typeid, ResponseData?.tYPEID);
          
print(ResponseData?.eMPNAME);
          Navigator.pushNamed(context, AppRoutes.otpscreen);
        } else if (ResponseData?.status == 'N') {
          showAlert(ResponseData!.message.toString());
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 500 ||
          e.response?.statusCode == 404) {
        showAlert("${e.response?.statusMessage}");
      }
    }
  }

  showAlert(String message, {String text = ""}) {
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
            // title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
                //style: ButtonStyle(backgroundColor:),
              )
            ],
          );
        }); //showDialog
  } //

  readsharedprefData() async {
    final otp = await SharedPreferencesClass().readTheData("otp");

    //print("otp value from sharedpre is $otp");

    setState(() {
      otpValue = otp;
    });
  }
}
