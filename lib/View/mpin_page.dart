import 'package:flutter/material.dart';

class MyMpinDesign extends StatefulWidget {
  const MyMpinDesign({super.key});

  @override
  State<MyMpinDesign> createState() => _MyMpinDesignState();
}

class _MyMpinDesignState extends State<MyMpinDesign> {
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
        width: MediaQuery.of(context).size.width*1,
        height: MediaQuery.of(context).size.height*1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 2.0, horizontal: 40.0),

          child: SingleChildScrollView(
            child: Card(
              elevation: 15.0,
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 150.0),
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                 side: BorderSide(color: Colors.black87, width: 1),),
          
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
                      onPressed: () {},
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
                         /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyResetMpin(),
                              )); */
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(10)),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
