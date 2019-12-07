import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: TestScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreen createState() => _TestScreen();
}

class _TestScreen extends State {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  List<User> users = [];

  Future<List<User>> userDetails() async {
    if (users.length == 0) {
      var dataFromURL = await http.get("https://randomuser.me/api/?results=20");
      var jsonData = json.decode(dataFromURL.body);
      print(jsonData['results'][0]['email']);
      int index = 0;
      for (var user in jsonData['results']) {
        User data = User(
          index: index,
          email: user['email'],
          fname: user['name']['first'],
          lname: user['name']['last'],
          phone: user['phone'],
          pictureLarge: user['picture']['large'],
          pictureSmall: user['picture']['medium'],
          gender: user['gender'],
          dob: user['dob']['date'],
        );
        users.add(data);
        index++;
      }
    }
    return users;
  }

  _reload() async {
    users = [];
    setState(() {});
  }

  String menOrWomen(gender) {
    String imageURL = "";
    if (gender == "male") {
      imageURL = "images/man.png";
    } else {
      imageURL = "images/women.png";
    }
    return imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("หน้าลงทะเบียน"),
    ),
     body: new Container(
        child: new FutureBuilder(
          future: userDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    leading: new Hero(
                      tag: "image$index",
                      child: CircleAvatar(
                        backgroundImage:
                            new NetworkImage(snapshot.data[index].pictureSmall),
                      ),
                    ),
                    title: new Text(
                      capitalize(snapshot.data[index].fname) +
                          " " +
                          capitalize(snapshot.data[index].lname),
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: new Text(snapshot.data[index].email),
                    trailing: new SizedBox(
                      height: 20.0,
                      child: new Image.asset(menOrWomen(snapshot.data[index].gender)),
                    ),
                    onTap: () {
                      
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Reload",
        child: new Icon(Icons.refresh),
        onPressed: () {
          _reload();
        },
      ),
    );
  }
}
  


String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class User {
  final int index;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String pictureSmall;
  final String pictureLarge;
  final String gender;
  final String dob;

  User(
      {this.index,
      this.fname,
      this.lname,
      this.email,
      this.phone,
      this.pictureSmall,
      this.pictureLarge,
      this.gender,
      this.dob});

  String fullName() {
    return capitalize(this.fname) + " " + capitalize(this.lname);
  }
}
