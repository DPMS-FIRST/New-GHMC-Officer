import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/constants/text_constants/text_constants.dart';

class ReusableSearchbar extends StatelessWidget {
  const ReusableSearchbar({
    super.key,
    required this.topPadding,
    required this.screenWidth,
    required this.screenHeight,
    required this.bgColor,
    required this.searchIcon,
    required this.onPressed, this.controller,
  });
  final double topPadding;
  final double screenWidth;
  final double screenHeight;
  final Color bgColor;
  final controller;

  final GestureTapCallback onPressed;

  final Icon searchIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * screenWidth,
            height: MediaQuery.of(context).size.height * screenHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 50.0,
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          hintText: TextConstants.Complaint_id,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed:
                        onPressed /* () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                       
                  }, */
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* class CustomSearchDelegate extends SearchDelegate {
  List<String> searchResults = ["12", "23", "34", "56"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
            //
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, null);
        }),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
          child: TextWidget(
        text: query,
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        textcolor: Colors.green,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = searchResults.where((element) {
      final res = element.toLowerCase();
      final input = query.toLowerCase();
      return res.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: ((context, index) {
          var result = matchquery[index];
          return ListTile(
            title: Text("${result}"),
            onTap: (() {
              query = result;
              showResults(context);
            }),
          );
        }));
  }
}
 */