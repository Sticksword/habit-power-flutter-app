import 'package:flutter/material.dart';
import 'package:json_api/json_api.dart';

import 'package:habit_power/models/success_story.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        FutureBuilder<List<SuccessStory>>(
          future: getSuccessStories(),
          builder: (context, AsyncSnapshot<List<SuccessStory>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var result = results[index];
                  return ListTile(
                    title: Text(result.bodyJson),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes. 
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
String url = 'http://ed8a74bd.ngrok.io/api/success_stories';
Future<List<SuccessStory>> getSuccessStories() async {
  print('fetching');
  Map<String, String> requestHeaders = {
    'Content-type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json',
  };

  final userId = '1';
  final uri = '$url/$userId/following';

  final client = JsonApiClient();
  final companiesUri = Uri.parse(uri);
  
  final response = await client.fetchCollection(companiesUri, headers: requestHeaders);

  print('Status: ${response.status}');
  print('Headers: ${response.headers}');

  print('The included resource is ${response.data.included}');
  print('${response.data.collection}');
  List<SuccessStory> successStories = response.data.collection.map((rawJson) => SuccessStory.fromJson(rawJson.attributes)).toList();


  return successStories;
}