import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:json_api/json_api.dart';

import 'models/user.dart';
import 'models/objective.dart';
import 'dart:developer';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building user widget');
    return Scaffold(            
      appBar: AppBar(
        title: Text('User Profile'),            
      ),            
      body: Center(            
        child: FutureBuilder<User>(
            future: getUser(),
            builder: (context, snapshot) {
              // print(snapshot);
              // print(snapshot.hasData);
              if(snapshot.hasData)
                return Text('Hi ${snapshot.data.firstName}!');
              else
                return CircularProgressIndicator();
            }
        )
      )
    );
  }
}

String url = 'http://413dc506.ngrok.io/api/users';
Future<User> getUser() async{
  print('fetching');
  Map<String, String> requestHeaders = {
    'Content-type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json',
  };

  final username = 'swaglord';
  final uri = '$url/$username';
  // final test = await http.get(uri, headers: requestHeaders);
  // print(test.body);

  final client = JsonApiClient();
  final companiesUri = Uri.parse(uri);
  
  final response = await client.fetchResource(companiesUri, headers: requestHeaders);

  print('Status: ${response.status}');
  print('Headers: ${response.headers}');

  final resource = response.data.toResource();
  
  print('The resource is ${response.data.included}');
  List<Objective> objectives = response.data.included.map((rawObjective) => Objective.fromJson(rawObjective.attributes)).toList();
  debugger();

  // print('Attributes:');
  // resource.attributes.forEach((k, v) => print('$k=$v'));

  User user = User.fromJson(resource.attributes);
  print(user.firstName);

  print('Relationships:');
  resource.toOne.forEach((k, v) => print('$k=$v'));
  resource.toMany.forEach((k, v) => print('$k=$v'));
  print(resource.toMany["objectives"].first);
  // debugger();
  return user;
}

