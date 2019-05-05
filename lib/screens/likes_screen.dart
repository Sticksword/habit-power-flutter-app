import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:json_api/json_api.dart';

import 'package:habit_power/models/user.dart';
import 'package:habit_power/models/success_story.dart';
import 'package:habit_power/utils/search_delegate.dart';
import 'dart:developer';

import 'dart:io';

class LikesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building likes widget');
    return Scaffold(            
      appBar: AppBar(
        title: Text('Likes')
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FutureBuilder<List<SuccessStory>>(
            future: getSuccessStories(),
            builder: (context, AsyncSnapshot<List<SuccessStory>> snapshot) {
              print(snapshot);
              // print(snapshot.hasData);
              if(snapshot.hasData)
                // return Text('Hi ${snapshot.data.firstName}!');
                return new Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    itemBuilder: (BuildContext context, int index) {
                      //if (index < 50)
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: ListTile(
                            leading: const Icon(Icons.account_circle,
                                size: 40.0, color: Colors.white30),
                            title: Text('MainItem $index'),
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

String url = 'http://ed8a74bd.ngrok.io/api/success_stories';
Future<List<SuccessStory>> getSuccessStories() async{
  return new List();
}

