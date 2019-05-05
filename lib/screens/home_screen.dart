import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:json_api/json_api.dart';

import 'package:habit_power/models/user.dart';
import 'package:habit_power/models/success_story.dart';
import 'dart:developer';

import 'dart:io';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building home widget');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: new Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: new Text('Your Current Objective')
          ),
          FutureBuilder<List<SuccessStory>>(
            future: getSuccessStories(),
            builder: (context, snapshot) {
              print(snapshot);
              // debugger();
              if(snapshot.hasData)
                if (snapshot.data.isEmpty)
                  return Text('Create a new objective!');
                else
                  return currentObjectiveSection;
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: new Text('Newsfeed')
          ),
          FutureBuilder<List<SuccessStory>>(
            future: getSuccessStories(),
            builder: (context, snapshot) {
              print(snapshot);
              // debugger();
              if (snapshot.hasData)
                if (snapshot.data.isEmpty)
                  return Text('oh noes, no one you follow has a success story');
                else
                  return new Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: ListTile(
                              leading: const Icon(Icons.account_circle,
                                  size: 40.0, color: Colors.white30),
                              title: Text('MainItem ${snapshot.data[index].bodyJson}'),
                              subtitle: Text('SubText $index'),
                            ),
                          ),
                          color: Colors.blue[400],
                          margin: EdgeInsets.all(1.0),
                        );
                      },
                    )
                  );
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          )
        ],
      )
    );
  }
}

Widget currentObjectiveSection = Column(
  children: [
    Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'get swole',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'eat well',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        new Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            shape: BoxShape.circle
          ),
          child: Text('41'),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.star, size: 40.0, color: Colors.red),
        new Text('test')
      ],
    )
  ]
);



String url = 'http://ed8a74bd.ngrok.io/api/success_stories';
Future<List<SuccessStory>> getSuccessStories() async{
  print('fetching');
  Map<String, String> requestHeaders = {
    'Content-type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json',
  };

  final userId = '1';
  final uri = '$url/$userId/following';
  // final test = await http.get(uri, headers: requestHeaders);
  // print(test.body);

  final client = JsonApiClient();
  final companiesUri = Uri.parse(uri);
  
  final response = await client.fetchCollection(companiesUri, headers: requestHeaders);

  print('Status: ${response.status}');
  print('Headers: ${response.headers}');

  // final resource = response.data.collection.first;
// expect(r.data.collection.first.attributes['name'], 'Tesla');
// expect(r.data.collection.first.self.uri.toString(),
  print('The included resource is ${response.data.included}');
  print('${response.data.collection}');
  List<SuccessStory> successStories = response.data.collection.map((rawJson) => SuccessStory.fromJson(rawJson.attributes)).toList();
  // debugger();

  // print('Attributes:');
  // resource.attributes.forEach((k, v) => print('$k=$v'));

  return successStories;
}

