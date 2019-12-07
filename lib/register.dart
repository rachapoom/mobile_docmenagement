import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/main.dart';


void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("หน้าลงทะเบียน"),),
      body: ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "FirstName", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "Lastname", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "Email", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "Username", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "Password", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
          child: TextField(
          decoration: InputDecoration(
              hintText: "Confrim Password", contentPadding: EdgeInsets.all(10.0)),
        ),
        ),
       Container(
          margin: EdgeInsets.only(left: 60.0,right: 60.0,top: 30.0),
          child: RaisedButton(
          onPressed: () => {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => DocApp()))
          },
          color: Colors.green,
          padding: EdgeInsets.all(15.0),
          child: Text(
            'ยืนยัน',
            style: TextStyle(color: Colors.white),
          ),
        )
        )
      ],
    ));
  }
}
