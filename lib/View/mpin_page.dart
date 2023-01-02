import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

import 'package:ghmc_officer/res/components/sharedpreference.dart';

import 'package:ghmc_officer/View/GhmcDashboard.dart';

class MyMpinDesign extends StatefulWidget {
  const MyMpinDesign({super.key});

  @override
  State<MyMpinDesign> createState() => _MyMpinDesignState();
}

class _MyMpinDesignState extends State<MyMpinDesign> {
  TextEditingController num = TextEditingController();
  List<String> otpValue = [];
  String mpinValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            TextConstants.mpin_login,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
        ],
        //
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstants.bg),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 15.0,
                    margin: const EdgeInsets.symmetric(vertical: 150.0),
                    color: Color.fromARGB(0, 39, 38, 38),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              mpinValue = output;

                              // Your logic with pin code
                              // print(output);
                            },
                          ),

                          //login button
                          ElevatedButton(
                            onPressed: () async {
                              var res = await SharedPreferencesClass()
                                  .readTheData("mpin");
                              var desg = await SharedPreferencesClass()
                                  .readTheData(PreferenceConstants.designation);

                              // print("read mpin from  sahredpref in login is  ${res}");
                              // print("user enterd value in login screen ${mpinValue}");
                              if (res == mpinValue) {
                                print(res);

                                Navigator.pushNamed(
                                    context, AppRoutes.ghmcdashboard);
                              } else {
                                showAlert(TextConstants.invalid_mpin);
                                mpinValue = '';
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: Color.fromARGB(255, 173, 48, 90),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Text(
                              TextConstants.login,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),

                          //Reset Mpin
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
                  ),
                ),
              ),
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
