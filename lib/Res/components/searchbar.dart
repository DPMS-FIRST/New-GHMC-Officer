import 'package:flutter/material.dart';


class ReusableSearchbar extends StatelessWidget {
  const ReusableSearchbar(
      {super.key,
      required this.topPadding,
      required this.screenWidth,
      required this.screenHeight,
      required this.bgColor,
      required this.searchIcon, required this.onPressed, });
  final double topPadding;
  final double screenWidth;
  final double screenHeight;
  final Color bgColor;
  
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
            child: Card(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: onPressed /* () {
                        showSearch(
                            context: context, delegate: CustomSearchDelegate());
                           
                      }, */
                    ), 
                    
                  ],
                )),
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