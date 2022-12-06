import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/search_response.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();
  SearchByComplaintIdResponse? _searchByComplaintIdResponse;

  final List<String>  duplicateItems=["swathi", "lavvi","manisha"];
  //List<String>.generate(10000, (i) => "Item $i");
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    fetchDetails();
    items=duplicateItems;
   
   
   
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      print("dummylistData ${dummyListData}");
      return;
    }
     else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
        
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("SearchBar"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                var ite=items[index];
                 
             
              

                  return ListTile(
                    title: Text('${ite}'),
                    // Text('${items[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  fetchDetails() async{
    final requestUrl = ApiConstants.search_baseurl + ApiConstants.search_endpoint;
    final requestPayload = {
      "userid":"cgg@ghmc",
      "password":"ghmc@cgg@2018",
      "compId":"270822556445",
      "Uid":"978"
      };
    final dio_object=Dio();
 try {
      final response = await dio_object.post(
        requestUrl,
        data: requestPayload,
      );
       
      
      
        final data=SearchByComplaintIdResponse.fromJson(response.data);
        
       var len =data.grievance?.length;
       for(var i=0;i<len!;i++){
        setState(() {
          duplicateItems.add("${data.grievance![i].id}");
        });
        
        // print(data.grievance![i].id);
        // print(duplicateItems);
         
         // print(items);
          
        
       }
 
      


    } on DioError catch (e) {
     
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }
  
 
  }


