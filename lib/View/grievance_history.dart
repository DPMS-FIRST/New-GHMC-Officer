import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghmc_officer/Model/history_response.dart';
import 'package:ghmc_officer/Model/shared_model.dart';

import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';

import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class GrievanceHistory extends StatefulWidget {
  const GrievanceHistory({super.key});

  @override
  State<GrievanceHistory> createState() => _GrievanceHistoryState();
}

class _GrievanceHistoryState extends State<GrievanceHistory> {
  GrievanceHistoryResponse? grievanceHistoryResponse;
  String? _backgroundImage;
  String? _backgroundImage2;
  String? _backgroundImage3;
  String? _currentAddress;
  bool enabledropdown = false;
  bool comments = false;
  bool directions = false;
  Position? _currentPosition;
  String? long;
  String? lat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          TextConstants.grievance_history,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImage(imgPath: ImageConstants.bg),
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount:
                          grievanceHistoryResponse?.grievance?.length ?? 0,
                      itemBuilder: (context, index) {
                        final details =
                            grievanceHistoryResponse?.grievance?[index];
                        var splitted_latlong = details?.latlon?.split(",");

                        lat = splitted_latlong?[0];

                        long = splitted_latlong?[1];

                        if (grievanceHistoryResponse?.grievanceFlag == "true" &&
                            grievanceHistoryResponse?.commentsFlag == "true") {
                          if (grievanceHistoryResponse!.comments!.isNotEmpty &&
                              details?.latlon != "0.0,0.0") {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                directions = true;
                                comments = true;
                              });
                            });
                          } else if (grievanceHistoryResponse!
                                  .comments!.isNotEmpty &&
                              details?.latlon == "0.0,0.0") {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                directions = false;
                                comments = true;
                              });
                            });
                          }
                        } else if (grievanceHistoryResponse?.commentsFlag ==
                            "true") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (grievanceHistoryResponse!
                                .comments!.isNotEmpty) {
                              setState(() {
                                comments = true;
                              });
                            } else {
                              setState(() {
                                comments = false;
                              });
                            }

                            // Add Your Code here.
                          });
                        } else if (grievanceHistoryResponse?.grievanceFlag ==
                            "true") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (details?.latlon == "0.0,0.0") {
                              setState(() {
                                directions = false;
                              });
                            } else {
                              setState(() {
                                directions = true;
                              });
                            }
                          });
                        }
                        return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black87, width: 1),
                            ),
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                RowComponent(
                                  TextConstants.id,
                                  details?.id,
                                ),
                                RowComponent(
                                  TextConstants.type,
                                  details?.type,
                                ),
                                RowComponent(
                                  TextConstants.time,
                                  details?.timeStamp,
                                ),
                                RowComponent(TextConstants.mobile_number,
                                    details?.mobileno,
                                    ico: IconButton(
                                        onPressed: () {
                                          launch("tel:${details?.mobileno}");
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          color:
                                              Color.fromARGB(255, 40, 133, 43),
                                        ))),
                                RowComponent(
                                  TextConstants.status,
                                  details?.status,
                                ),
                                RowComponent(
                                  TextConstants.posted_by,
                                  details?.userName,
                                ),
                                RowComponent(
                                  TextConstants.landmark,
                                  details?.landmark,
                                ),
                                RowComponent(
                                  TextConstants.remarks,
                                  details?.remarks,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    setImage(_backgroundImage = details?.photo),
                                    setImage(
                                        _backgroundImage3 = details?.photo2),
                                    setImage(
                                        _backgroundImage3 = details?.photo3),
                                  ],
                                )
                              ],
                            ));
                      })),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                directions
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          //width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Card(
                            color: Colors.transparent,
                            child: textButton(
                              text: TextConstants.view_directions,
                              textcolor: Colors.white,
                              onPressed: () {
                                double lattitude = double.parse(lat.toString());
                                double longitude =
                                    double.parse(long.toString());
                                _launchMapsUrl(lattitude,longitude);
                                //  navigateTo(lattitude, longitude);
                                // MapsLauncher.launchCoordinates(
                                //     lattitude,
                                //     longitude,
                                //    );
                                // _getCurrentPosition();

                                //  MapUtils.openMap(lattitude,longitude);
                                // Navigator.pushNamed(context, AppRoutes.viewcomment);
                              },
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                comments
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          //  width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Card(
                            color: Colors.transparent,
                            child: Center(
                              child: textButton(
                                text: TextConstants.view_comments,
                              
                                textcolor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.viewcomment);
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                Expanded(
                  flex: 1,
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Card(
                      color: Colors.transparent,
                      child: textButton(
                        text: TextConstants.take_action,
                        textcolor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.takeaction);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RowComponent(var data, var value, {IconButton? ico}) {
    //final void Function()? onpressed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(child: ico),
          ),
        ],
      ),
    );
  }

  setImage(_backgroundImage) {
    if (_backgroundImage.toString().contains('.pdf')) {
      _backgroundImage = ImageConstants.viewpdf;
      return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Image.asset(
          "${_backgroundImage}",
          width: 100,
          height: 80,
        ),
      );
    } else {
      _backgroundImage = ImageConstants.viewimage;
      return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Image.asset(
          "${_backgroundImage}",
          width: 100,
          height: 90,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    var compid = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.historydetails);
    var uid =
        await SharedPreferencesClass().readTheData(PreferenceConstants.uid);
//creating request url with base url and endpoint
    const requesturl =
        ApiConstants.baseurl + ApiConstants.history_endpoint;
    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "compId": compid,
      "Uid": uid
    };

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = GrievanceHistoryResponse.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "success") {
          EasyLoading.dismiss();
          if (data.grievance != null && data.grievance!.length > 0) {
            grievanceHistoryResponse = data;
          }
        }
      });

      print(
          " grivance latlon ${grievanceHistoryResponse?.grievance![0].latlon}");
      var split = grievanceHistoryResponse?.grievance?[0].latlon?.split(",");
      print(split?[0]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        //final errorMessage = e.response?.data["message"];
        // showAlert(errorMessage);
      }
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //setState(() {});
  }

//handling permissions
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services adre disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

//get current location
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    double lattitude = double.parse(lat.toString());
    double longitude = double.parse(long.toString());
    // 2.0

    // await placemarkFromCoordinates(
    //         _currentPosition!.latitude, _currentPosition!.longitude)
    await placemarkFromCoordinates(lattitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      Placemark area = placemarks[1];
      print(area.locality);
      setState(() {
        _currentAddress =
            ' ${place.street}, ${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode},';
      });
      print("address : ${_currentAddress}");
    }).catchError((e) {
      debugPrint(e);
    });
  }


  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}