import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
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
            "MPIN Login",
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
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 40.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 15.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 150.0),
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black87, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),

                    //login button
                    ElevatedButton(
                      onPressed: () async {
                        var res =
                            await SharedPreferencesClass().readTheData("mpin");
                        
                        /*  var name=
                            await SharedPreferencesClass().readTheData("ename"); */
                        print("result is ${res}");
                        print(mpinValue);
                        if (res == mpinValue) {
                          Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                        } else {
                          showAlert("Invalid MPIN");
                          mpinValue = '';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'Login',
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
                          "Reset MPIN?",
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
    );
  }

  Widget _textFieldOTP({bool? first, last}) {
    return SizedBox(
      height: 84,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            //otpValue.add(value);
            mpinValue += value.toString();
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
          color: Colors.white),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
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
                child: Text("ok"),
                //style: ButtonStyle(backgroundColor,
              )
            ],
          );
        }); //showDialog
  } //
}