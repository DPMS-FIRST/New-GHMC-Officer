import 'dart:io';

import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Privacy Policy'),
      ),
      body: ContainedTabBarView(
        tabs: [
          Text('First'), 
          Text('Second'), 
          Text('Third')
          ],
        tabBarProperties: TabBarProperties(
          height: 32.0,
          indicatorColor: Colors.black,
          indicatorWeight: 6.0,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[400],
        ),
        views: [
          Container(
            child: WebView(
              initialUrl: 'https://flutter.dev',
            ), 
          ),
          Container(), 
          Container()
          ],
        onChange: (index) => print(index),
      ),
    );
  }

   @override
   void initState() {
     super.initState();
     // Enable virtual display.
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   } 

   
}
