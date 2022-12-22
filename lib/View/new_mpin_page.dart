import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:ghmc_officer/View/GhmcDashboard.dart';

class Mpin extends StatefulWidget {
  const Mpin({super.key});

  @override
  State<Mpin> createState() => _MpinState();
}

class _MpinState extends State<Mpin> {
  String? mpinValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                   margin:
                        const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87, width: 1),
                    ),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      PinCodeFields(
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: 50.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.0,
                        activeBorderColor: Colors.black,
                        activeBackgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        fieldBackgroundColor: Colors.black12,
                        borderColor: Colors.black38,
                        textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        onComplete: (output) {
                          mpinValue=output;
                          //print(output);
                          // mpinValue = output;
                        },
                      ),
                       ElevatedButton(
                            onPressed: () async {
                            // readsharedprefData();
                            var res =
                                  await SharedPreferencesClass().readTheData(PreferenceConstants.mpin);
          
                              // print("read mpin from  sahredpref in login is  ${res}");
                              // print("user enterd value in login screen ${mpinValue}");
                              if (res == mpinValue) {
                                Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                              } else {
                                showAlert(TextConstants.invalid_mpin);
                                mpinValue = '';
                              }
          
                              // print("read mpin from  sahredpref in login is  ${res}");
                              // print("user enterd value in login screen ${mpinValue}");
                             
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: Color.fromARGB(255, 173, 48, 90),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              TextConstants.login,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),

                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GhmcDashboard(),
                                    ));
                              },
                              child: const Text(
                                TextConstants.reset_mpin,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  decoration: TextDecoration.underline,
                                ),
                              ))
                    ],
                  ),

                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                  print("clicked");
                  // print("button Action");
                  Navigator.pop(context);
                },
                child: Text(TextConstants.ok),
                //style: ButtonStyle(backgroundColor,
              )
            ],
          );
        }); //showDialog
  } //
  
}
