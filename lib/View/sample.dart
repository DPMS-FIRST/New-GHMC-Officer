import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(  
                      obscureText: true,  
                      decoration: InputDecoration(  
                        border: OutlineInputBorder(),  
                        labelText: 'Password',  
                        hintText: 'Enter Password',  
                      ),  
                    ),
            ),

            Expanded(
              flex: 2,
              child: TextField(  
                      obscureText: true,  
                      decoration: InputDecoration(  
                        border: OutlineInputBorder(),  
                        labelText: 'Password',  
                        hintText: 'Enter Password',  
                      ),  
                    ),
            ),
          ],
        ),
      ),
    );
  }
}