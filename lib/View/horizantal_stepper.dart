import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _elements = [
  {'name': 'Virat Kohli', 'group': 'RCB'},
  {'name': 'Rohit Sharma', 'group': 'MI'},
  {'name': 'AB de Villiers', 'group': 'RCB'},
  {'name': 'Jasprit Bumrah', 'group': 'MI'},
  {'name': 'KL Rahul', 'group': 'KXIP'},
  {'name': 'Md. Shammi', 'group': 'KXIP'},
];

class HorizantalStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GeeksForGeeks'),
          backgroundColor: Colors.green,
        ),
        body: GroupedListView<dynamic, String>(
          elements: _elements,
          groupBy: (element) => element['group'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['name'].compareTo(item2['name']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: ImageIcon(NetworkImage(
                      'http://www.pngall.com/wp-content/uploads/2017/04/IPL-Logo-2017-PNG.png')),
                  title: Text(element['name']),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
