import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: HomeApp(),
  ));
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  List responseJSON;
  Future<String> ambilData() async {
    http.Response response = await http
        .get(Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"));

    setState(() {
      responseJSON = JSON.decode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView JSON"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: responseJSON == null ? 0 : responseJSON.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        responseJSON[i]['title'],
                        style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      ),
                      Text(responseJSON[i]['body'])
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
