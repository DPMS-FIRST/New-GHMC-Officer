
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

class OtpNewScreen extends StatefulWidget {
  const OtpNewScreen({super.key});

  @override
  State<OtpNewScreen> createState() => _OtpNewScreenState();
}

class _OtpNewScreenState extends State<OtpNewScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  TextEditingController Otp = TextEditingController();
  String otpValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            TextConstants.verification_code,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.bg), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.50,
            color: const Color.fromARGB(255, 58, 71, 77),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const TextWidget(
                        text: TextConstants.sent_code,
                        textcolor: Colors.white,
                        fontsize: 17,
                        left: 10,
                        right: 80,
                        top: 20,
                        bottom: 0),
                    Padding(
                      padding: const EdgeInsets.only(right: 150, left: 160),
                      child: TextFormField(
                        controller: Otp,
                        /*  onChanged: (text) {
                          if (text.isNotEmpty) {
                            setState(() {
                              valid();
                            });
                            print("not empty");
                          } else {
                            v();
                            print("empty");
                          }
                        }, */
                        maxLength: 4,
                        style: const TextStyle(color: Colors.white),
                        onTap: () {
                          FocusNode().hasFocus ? valid() : v();
                        },
                        cursorColor: const Color.fromRGBO(33, 121, 110, 1),
                        focusNode: myFocusNode,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: TextConstants.hinttext_otp,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: myFocusNode.hasFocus
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                      ),
                    ),
                    v()

                    /*  FocusNode().hasFocus ? valid() : v(),
                    Text("${FocusNode().hasFocus}"), */

                    // v(),
                    //valid(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
   
    super.initState();
    
  }

  @override
  void dispose() {
    Otp.dispose();
    super.dispose();
  }

  v() {
    return Container(
      child: Column(
        children: [
          /*  textButton(
            
            text: "VALIDATE OTP",
            height: 45,
            width: 150,
            backgroundcolor: Colors.pinkAccent,
          ), */
          ElevatedButton(
              onPressed: (() async {
                final result =
                    await SharedPreferencesClass().readTheData("otp");
               // print("otp from shared preference ${result}");
                //print(Otp.text);
                if (result == Otp.text) {
                  Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
                } else {
                  showAlert(TextConstants.invalid_otp);
                }
              }),
              child: const Text(TextConstants.validate)),
          const TextWidget(
              text: "Waiting for OTP: 00: 10 ",
              textcolor: Colors.white,
              fontsize: 17,
              left: 0,
              right: 0,
              top: 20,
              bottom: 0),
        ],
      ),
    );
  }

  valid() {
    return Container(
      child: Column(
        children: const [
          /* textButton(
            text: "VALIDATE OTP",
            height: 45,
            width: 150,
            backgroundcolor: Colors.pinkAccent,
          ), */
          TextWidget(
              text: "Don't Recieve the code? ",
              textcolor: Colors.white,
              fontsize: 17,
              left: 0,
              right: 0,
              top: 20,
              bottom: 0),
          textButton(
            text: "RESEND",
            height: 45,
            width: 150,
            backgroundcolor: Colors.pinkAccent,
          )
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
                child: Text("ok"),
                //style: ButtonStyle(backgroundColor:),
              )
            ],
          );
        }); //showDialog
  } //
}
