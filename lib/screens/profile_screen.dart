import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:json_api/json_api.dart';

import '../models/user.dart';
import '../models/objective.dart';
import 'dart:developer';

class ProfileScreen extends StatelessWidget {
  Function logout;

  ProfileScreen({@required this.logout});

  @override
  Widget build(BuildContext context) {
    print('building profile widget');
    return Scaffold(            
      appBar: AppBar(
        title: Text('User Profile'),            
      ),            
      body: Column(            
        children: [
          FutureBuilder<User>(
            future: getUser(),
            builder: (context, snapshot) {
              // print(snapshot);
              // print(snapshot.hasData);
              if(snapshot.hasData)
                return Text('Hi ${snapshot.data.firstName}!');
              else
                return CircularProgressIndicator();
            }
          ),
          RaisedButton(
            child: Text('Log out'),
            onPressed: () {
              // Navigate to the second screen using a named route
              // Navigator.pushReplacementNamed(context, '/');
              logout();
            },
          ),
        ]
      )
    );
  }
}

String url = 'http://ed8a74bd.ngrok.io/api/users';
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
  final userUri = Uri.parse(uri);
  
  final response = await client.fetchResource(userUri, headers: requestHeaders);

  print('Status: ${response.status}');
  print('Headers: ${response.headers}');

  final resource = response.data.toResource();
  
  print('The included resource is ${response.data.included}');
  if (response.data.included != null) {
    List<Objective> objectives = response.data.included.map((rawObjective) => Objective.fromJson(rawObjective.attributes)).toList();
  }
  // debugger();

  // print('Attributes:');
  // resource.attributes.forEach((k, v) => print('$k=$v'));

  User user = User.fromJson(resource.attributes);
  print(user.firstName);

  print('Relationships:');
  resource.toOne.forEach((k, v) => print('$k=$v'));
  resource.toMany.forEach((k, v) => print('$k=$v'));
  print(resource.toMany["objectives"]);
  // debugger();
  return user;
}

