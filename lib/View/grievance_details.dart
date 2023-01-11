import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/model/grievance_details_response.dart';
import 'package:ghmc_officer/model/shared_model.dart';
import 'package:ghmc_officer/res/components/background_image.dart';
import 'package:ghmc_officer/res/components/button.dart';
import 'package:ghmc_officer/res/components/sharedpreference.dart';
import 'package:ghmc_officer/res/components/textwidget.dart';
import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/res/constants/app_constants.dart';
import 'package:ghmc_officer/res/constants/routes/app_routes.dart';

import 'package:ghmc_officer/res/constants/text_constants/text_constants.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GrievanceDetails extends StatefulWidget {
  const GrievanceDetails({
    super.key,
  });

  @override
  State<GrievanceDetails> createState() => _GrievanceDetailsState();
}

class _GrievanceDetailsState extends State<GrievanceDetails> {
  GrievanceDetailsResponse? _grievanceDetailsResponse;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<Comments>? commentsItems;
  bool commentsbutton = false;
  bool postbutton = false;
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
              })
              //() => Navigator.of(context).pop(),
              ),
          title: Center(
            child: Text(
              "Grievance Details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: ImageConstants.bg),
            ListView.builder(
                itemCount: _grievanceDetailsResponse?.grievance?.length ?? 0,
                itemBuilder: ((context, index) {
                  final details = _grievanceDetailsResponse?.grievance?[index];
                  if (_grievanceDetailsResponse?.comments != null &&
                      _grievanceDetailsResponse!.comments!.length > 0) {
                    if (_grievanceDetailsResponse?.comments?[index].flag !=
                        "false") {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          commentsbutton = true;
                        });
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          commentsbutton = false;
                        });
                      });
                    }
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.white,
                            child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  RowComponent(
                                      TextConstants.grievance_details_id,
                                      details?.id),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_type,
                                      details?.type),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_landmark,
                                      details?.landmark),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_mobile,
                                      details?.mobileno),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_time,
                                      details?.timeStamp),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_status,
                                      details?.status),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_status,
                                      details?.status),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_postedby,
                                      details?.userName),
                                  Line(),
                                  RowComponent(
                                      TextConstants.grievance_details_remarks,
                                      details?.remarks),
                                  Line(),
                                  RowComponent(
                                      TextConstants
                                          .grievance_details_assignedto,
                                      details?.assignedto),
                                ])),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setImage(
                            details!.photo,
                            onTap: () {
                              if (details.photo!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showAlert(details.photo);
                              } else if (details.photo!.contains('.jpg') ||
                                  details.photo!.contains('.png') ||
                                  details.photo!.contains('.jpeg')) {
                                showAlertImage(details.photo);
                              }
                            },
                          ),
                          setImage(
                            details.photo2,
                            onTap: () {
                              if (details.photo2!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showAlert(details.photo2);
                              } else if (details.photo2!.contains('.jpg') ||
                                  details.photo2!.contains('.png') ||
                                  details.photo2!.contains('.jpeg')) {
                                showAlertImage(details.photo2);
                              }
                            },
                          ),
                          setImage(
                            details.photo3,
                            onTap: () {
                              if (details.photo3!.contains('.pdf')) {
                                _pdfViewerKey.currentState?.openBookmarkView();
                                showAlert(details.photo3);
                              } else if (details.photo3!.contains('.jpg') ||
                                  details.photo3!.contains('.png') ||
                                  details.photo3!.contains('.jpeg')) {
                                showAlertImage(details.photo3);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          commentsbutton
                              ? Expanded(
                                  flex: 1,
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: textButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        text: TextConstants.view_comments,
                                        textcolor: Colors.white,
                                        onPressed: () {
                                          /* Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CheckstatusComments(
                                                        commentsList: [
                                                          commentsItems
                                                        ],
                                                      ))); */
                                          EasyLoading.show();
                                          Navigator.pushNamed(context,
                                              AppRoutes.checkstatuscomments);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Text(""),
                          Expanded(
                            flex: 1,
                            child: Card(
                              color: Colors.transparent,
                              child: Center(
                                child: textButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  text: TextConstants
                                      .grievance_details_postcomment,
                                  textcolor: Colors.white,
                                  onPressed: () {
                                    EasyLoading.show();
                                    Navigator.pushNamed(
                                        context, AppRoutes.postcomment);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                })),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchGrievanceDetails();
    // commentsList = widget.storecomments;
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }

  showAlert(String? photo) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SfPdfViewer.network(
            photo!,
            onDocumentLoadFailed: ((details) {
              print("not working");
            }),
            key: _pdfViewerKey,
          );
        });
    //showDialog
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
                      child: /* FadeInImage(image: NetworkImage(photo!), 
                placeholder: AssetImage(ImageConstants.no_uploaded),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageConstants.no_uploaded, fit: BoxFit.fitWidth,);
                },
                fit: BoxFit.fitWidth,
                ) */
                          Image.network(
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
                textcolor: Colors.grey,
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

  fetchGrievanceDetails() async {
    var mobileno = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.mobileno);
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.check_status_id);
    final url = ApiConstants.baseurl + ApiConstants.grievance_details_endpoint;
    final payload = {
      "userid": Constants.userid,
      "password": Constants.password,
      "MobileNo": mobileno,
      "CompId": compid
    };
    final dioObject = Dio();
    try {
      final response = await dioObject.post(
        url,
        data: payload,
      );

      final data = GrievanceDetailsResponse.fromJson(response.data);

      setState(() {
        if (data.status == "success") {
          EasyLoading.dismiss();
          _grievanceDetailsResponse = data;
          if (_grievanceDetailsResponse?.comments != null) {
            commentsItems = _grievanceDetailsResponse?.comments;
            Constants.commentsItemsList = commentsItems;
          }
          if (_grievanceDetailsResponse?.grievance != null) {
            for (var i = 0;
                i < _grievanceDetailsResponse!.grievance!.length;
                i++) {
              Constants.grievancedetailslatlon =
                  "${_grievanceDetailsResponse?.grievance?[i].latlon}";
                   Constants.grievancedetailsremarks =
                  "${_grievanceDetailsResponse?.grievance?[i].remarks}";
                  
                   Constants.grievancedetailsphoto =
                  "${_grievanceDetailsResponse?.grievance?[i].photo}";
                   Constants.grievancedetailsupdatedstatus =
                  "${_grievanceDetailsResponse?.grievance?[i].statusid}";
                   Constants.grievancedetailsmobileno =
                  "${_grievanceDetailsResponse?.grievance?[i].mobileno}-${_grievanceDetailsResponse?.grievance?[i].assignedto}";
                  

            }
          }
        }
      });

      print("lenth ${commentsItems?.length}");
    } on DioError catch (e) {
      print(e);
    }
  }
}
