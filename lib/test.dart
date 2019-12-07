import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_docmenagement/register.dart';
import 'dart:convert';

class LandingScreen extends StatefulWidget {
  int _userId;
  LandingScreen(int userId) {
    this._userId = userId;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LandingScreen(this._userId);
  }
}

class _LandingScreen extends State {
  int _userId;
  List<Widget> lstData = List();
  _LandingScreen(int userId) {
    this._userId = userId;
  }
  @override
  void initState() {
    print("Init State");
    super.initState();
    http
        .get(
            "http://www.mocky.io/v2/5ddc2fba3400008e4feae1f1")
        .then((response) {
      Map ret = jsonDecode(response.body) as Map;
      // print(response.toString());
      print(ret["data"]["group_name"]);
      List<dynamic> jsonData = ret["data"];
      print("This is log");
      // print(ret["data"]);
      for (int i = 0; i < jsonData.length; i++) {
        Map dataMap = jsonData[i];
        Card card = Card(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          new Row(
            children: <Widget>[
              Text(ret["data"]["group_name"]),
              Icon(
                Icons.restaurant,
                size: 30,
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Text("ชื่อกลุ่ม : "),
              Text(ret["data"]["group_name"]),
            ],
          ),
        ]));
        lstData.add(card);
      }

      setState(() {});
    });
  }

  Widget getItem(BuildContext context, int index) {
    return lstData[index];
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('ของกินอร่อย 2019'),
      ),
      body: ListView.builder(
        itemBuilder: getItem,
        itemCount: lstData.length,
      ),
    );
  }
}
 
