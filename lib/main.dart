import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String statusText = "Start Server";
  startServer() async {
    setState(() {
      statusText = "Starting server on Port : 8080";
    });
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    print("Server running on IP : " +
        server.address.toString() +
        " On Port : " +
        server.port.toString());
    server.listen((request) {
      if (request.method == "POST") {
        // we handle POST REQUESTS HERE
        print("asghar");
        if (request.uri.path == "/communicate") {
          request.response
            ..headers.contentType =
                new ContentType("application", "json", charset: "utf-8")
            ..write({UniqueKey().toString(): "akbar"})
            ..close();
        }
      }
    });

    setState(() {
      statusText = "Server running on IP : " +
          server.address.toString() +
          " On Port : " +
          server.port.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startServer();
            },
            child: Text(statusText),
          )
        ],
      ),
    ));
  }
}
