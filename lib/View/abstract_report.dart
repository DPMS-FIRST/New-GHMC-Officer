import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:ghmc_officer/View/total_grievances.dart';

class AbstractReport extends StatelessWidget {
  AbstractReport({super.key});
  final _random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          TextConstants.abstract_report,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BgImage(imgPath: ImageConstants.bg),
          ListView.builder(
            itemCount: 6,
            itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:4.0, horizontal: 8.0),
                child: Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  [Random().nextInt(2) * 100], 
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.0) ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                         leading: Icon(Icons.person),
                         title: Column(
                          children: [
                              Text("Lavanya",
                              style: TextStyle(
                                color: Colors.black
                              ),
                              ),
                              Text("Lavanya",
                              style: TextStyle(
                                color: Colors.black
                              ),
                              )
                          ],
                         ),
                        ),
                        ),
                    ),
                ),
              );
              
            },)
        ],
      ),
    );
  }
}