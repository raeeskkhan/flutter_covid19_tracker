import 'package:flutter/material.dart';
import 'package:flutterjsoncomplex/model/json_parsing_complex.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class JsonParsingComplex extends StatefulWidget {
  @override
  _JsonParsingComplexState createState() => _JsonParsingComplexState();
}

class _JsonParsingComplexState extends State<JsonParsingComplex> {
  Future<MapListOfStats> data;

  var now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    Network network =
        Network(url: "https://pomber.github.io/covid19/timeseries.json");
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON COMPLEX"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<MapListOfStats> snapshot) {
              List<dynamic> allPosts;
              if (snapshot.hasData) {
                allPosts = snapshot.data.country;
                return Column(
                  children: <Widget>[
                    staticListTile(allPosts, context),
                    Divider(
                      height: 10.0,
                      color: Colors.redAccent,
                    ),
                    createListView(allPosts, context),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget createListView(List<Stats> allPosts, BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        child: ListView.builder(
            itemCount: allPosts.length,
            itemBuilder: (context, int index) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 5.0,
                  ),
                  ListTile(
                    title: Text("${allPosts[index].date}"),
                    subtitle: Text("${allPosts[index].confirmed}"),
                  ),
                ],
              );
            }),
      ),
    );
  }

  staticListTile(List<Stats> allPosts, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("${allPosts[allPosts.length - 1].date}"),
              SizedBox(
                height: 5.0,
              ),
              Text("${allPosts[allPosts.length - 1].confirmed}"),
            ],
          ),
        ),
//        ListTile(
//          title: Text("${allPosts[allPosts.length - 1].date}"),
//          subtitle: Text("${allPosts[allPosts.length - 1].confirmed}"),
//        ),
      ),
    );
  }
}

class Network {
  final String url;

  Network({this.url});

  Future<MapListOfStats> loadPosts() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      print(response.statusCode);
      //print(response.body);
      //return null;
      return MapListOfStats.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get Posts");
    }
  }
}
