import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/home.dart';

void main() {
  runApp(MaterialApp(
    home: EditGroupScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class EditGroupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditGroupScreen();
  }
}

class _EditGroupScreen extends State {
  void click() {
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("หน้าแก้ไขเอกสาร"),
        ),
        body: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "ชื่อกลุ่ม", contentPadding: EdgeInsets.all(10.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "รายละเอียดกลุ่ม", contentPadding: EdgeInsets.all(10.0)),
            ),
          ),
           Container(
          margin: EdgeInsets.only(left: 60.0,right: 60.0,top: 30.0),
          child: RaisedButton(
          onPressed: () => {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => HomeScreen()))
          },
          color: Colors.green,
          padding: EdgeInsets.all(15.0),
          child: Text(
            'ยืนยัน',
            style: TextStyle(color: Colors.white),
          ),
        )
        )
        ]));
  }
}
