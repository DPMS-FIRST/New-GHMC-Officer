import 'package:flutter/material.dart';
import 'package:ghmc_officer/model/check_status_response.dart';

class StepperPage extends StatelessWidget {
  final double _width;

  final List<String> _titles;
  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor = Colors.black;
  final double? lineWidth = 3.0;
  List<ViewGrievances>? _viewGrievancesdata;
  StepperPage(List<ViewGrievances>? _viewGrievances,
      {Key? key,
      required int curStep,
      required List<String> titles,
      required double width,
      required Color color})
      : _titles = titles,
        _curStep = curStep,
        _width = width,
        _activeColor = color,
        _viewGrievancesdata = _viewGrievances,
        assert(width > 0),
        super(key: key);

  Widget build(BuildContext context) {
    int _curStep = 1;
    var length = _viewGrievancesdata?.length ?? 0;
    for (var i = 0; i < length; i++) {
      if (_viewGrievancesdata?[i].status == "Open") {
        _iconViews();
      }
    }

    return Card(
        // width: this._width,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: _iconViews(),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _titleViews(),
        ),
      ],
    ));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, icon) {
      var circleColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;
      var iconColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          padding: EdgeInsets.all(0),
          decoration: new BoxDecoration(
            // color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
            border: new Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),

          /* child: Icon(
            Icons.radio_button_off_outlined,
            color: Colors.black,
            size: 20.0,
          ), */
        ),
      );

      //line between icons
      if (i != _titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: Colors.grey,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(Text(text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
          )));
    });
    return list;
  }
}
