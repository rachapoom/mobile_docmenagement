import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/register.dart';
import 'package:mobile_docmenagement/home.dart';
import 'package:mobile_docmenagement/test3.dart';
import 'package:mobile_docmenagement/test3.dart' as prefix0;
import 'package:mobile_docmenagement/test4.dart';
import 'package:mobile_docmenagement/test5.dart';

void main() {
  runApp(MaterialApp(
    home: DocApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class DocApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DocApp();
  }
}

class _DocApp extends State {
  int get userId => null;

  void click() {
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Image.asset("images/logo.png"),
          width: 300.0,
          height: 300.0,
          padding: EdgeInsets.all(35.0),
        ),
        Center(
          child: Text("Log-in to myApp", style: TextStyle(fontSize: 16.0)),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Username", contentPadding: EdgeInsets.all(10.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Password", contentPadding: EdgeInsets.all(10.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 60.0, right: 60.0, top: 30.0),
          child: RaisedButton(
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext) => HomeScreen()))
            },
            color: Colors.blue,
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Log-in',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 60.0, right: 60.0, top: 10.0),
            child: RaisedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext) => HomeScreen5()))
              },
              color: Colors.green,
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Register', 
                style: TextStyle(color: Colors.white)),
            ))
      ],
    ));
  }
}
