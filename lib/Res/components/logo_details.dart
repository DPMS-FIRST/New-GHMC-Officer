
import 'package:flutter/material.dart';


import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/components/textwidget.dart';


class LogoAndDetails extends StatefulWidget {
  const LogoAndDetails({super.key});

  @override
  State<LogoAndDetails> createState() => _LogoAndDetailsState();
}

class _LogoAndDetailsState extends State<LogoAndDetails> {
  String name = '';
  String mNumber = '';
  String des = '';
  @override
  Widget build(BuildContext context) {
   

    return Container(
      child: Column(children: [
        Image.asset(
          "assets/ghmc_logo_new.png",
          height: 80,
          width: 150,
        ),
        TextWidget(
          text: name,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
        TextWidget(
          text: des,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
        TextWidget(
          text: mNumber,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
      ]),
    );
  }

  @override
  void initState() {
  
    super.initState();
    readsharedprefData();
  }

  Future<void> readsharedprefData() async {
    final empName = await SharedPreferencesClass().readTheData("empName");
    var designation = await SharedPreferencesClass().readTheData("designation");
    var mobileNumber =
        await SharedPreferencesClass().readTheData("mobileNumber");
    // print("read value is $empName");
    // print("design  $designation");
    setState(() {
      name = empName;
    });
    setState(() {
      des = designation;
    });
    setState(() {
      mNumber = mobileNumber;
    });
  }
}