import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Model/grievance_details_response.dart';

import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';

import 'package:ghmc_officer/Res/components/textwidget.dart';

import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Res/constants/app_constants.dart';

class CheckstatusComments extends StatefulWidget {
  const CheckstatusComments({super.key});

  @override
  State<CheckstatusComments> createState() => _CheckstatusCommentsState();
}

class _CheckstatusCommentsState extends State<CheckstatusComments> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () async {
              EasyLoading.show();
              Navigator.pushNamed(context, AppRoutes.ghmcdashboard);
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
            })),
        title: Center(
          child: Text(
            "View Comments",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BgImage(imgPath: ImageConstants.bg),
        ListView.builder(
            itemCount: Constants.commentsItemsList?.length,
            itemBuilder: ((context, index) {
              var details = Constants.commentsItemsList?[index];
              if (Constants.commentsItemsList?[index].flag == "success") {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        RowComponent(
                            TextConstants
                                .grievance_details_viewComments_postedBy,
                            details?.cuserName),
                        Line(),
                        RowComponent(
                            TextConstants.grievance_details_viewComments_Mobile,
                            details?.cmobileno),
                        Line(),
                        RowComponent(
                            TextConstants.grievance_details_viewComments_Id,
                            details?.cid),
                        Line(),
                        RowComponent(
                            TextConstants
                                .grievance_details_viewComments_Remarks,
                            details?.cremarks),
                        Line(),
                        RowComponent(
                            TextConstants.grievance_details_viewComments_Status,
                            details?.cstatus),
                        Line(),
                        RowComponent(
                            TextConstants
                                .grievance_details_viewComments_timestamp,
                            details?.ctimeStamp),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              setImage(
                                details!.cphoto,
                                onTap: () {
                                  if (details.cphoto!.contains('.pdf')) {
                                    _pdfViewerKey.currentState
                                        ?.openBookmarkView();
                                    showAlert("${details.cphoto}");
                                  } else if (details.cphoto!.contains('.jpg') ||
                                      details.cphoto!.contains('.png') ||
                                      details.cphoto!.contains('.jpeg')) {
                                    showAlertImage(details.cphoto);
                                  }
                                },
                              ),
                            ])
                      ],
                    ),
                  ),
                );
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  return showAlert("No Records Found");
                });
              }
              return Text("");
            }))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    /*   WidgetsBinding.instance.addPostFrameCallback((_) async {
      Constants.commentsItemsList;
    }); */
    //  print("comments class ${Constants.commentsItemsList?[0].cdid}");
    // showAlert("No Records found");
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  showAlertImage(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            actions: [
              Center(
                  child: Container(
                      child: Image.network(
                photo!,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageConstants.no_uploaded);
                },
              ))),
            ],
          );
        });
  }

  setImage(_backgroundImage, {void Function()? onTap}) {
    if (_backgroundImage.contains('.pdf')) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset(
            ImageConstants.viewpdf,
            width: 80,
            height: 50,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset(
            ImageConstants.viewimage,
            width: 80,
            height: 60,
          ),
        ),
      );
    }
  }

  RowComponent(var data, var val) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              //Text("${data}",style: TextStyle(decoration: TextDecoration.underline),)
              child: TextWidget(
                text: "${data}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Color.fromARGB(255, 119, 116, 116),
                fontWeight: FontWeight.bold,
              )),
          Expanded(
              flex: 2,
              child: TextWidget(
                text: "${val}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.black,
                fontWeight: FontWeight.bold,
              ))
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
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(AppRoutes.grivancedetails));
                },
                child: Text(
                  TextConstants.ok,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        }); //showDialog
  }
}
