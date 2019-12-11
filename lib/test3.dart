import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/detail_user.dart';
import 'package:mobile_docmenagement/document.dart';
import 'package:mobile_docmenagement/add_group.dart';
import 'package:mobile_docmenagement/edit_group.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'home.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen2(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen2();
  }
}

class _HomeScreen2 extends State {
  String filteredUser(String s) => s[0].toUpperCase() + s.substring(1);

  List<User> users = List<User>();
  List<User> filteredUser1 = List<User>();

  Future<List<User>> userDetails() async {
    if (users.length == 0) {
      var dataFromURL =
          await http.get("http://www.mocky.io/v2/5ddffdf73500002863480a76");
      var jsonData = json.decode(dataFromURL.body);
      // print(jsonData['results'][0]['group_name']);
      int index = 0;
      for (var user in jsonData['results']) {
        print(user["group_name"]);
        User data = User(
          index: index,
          groupName: user['group_name'],
          // docList: user['doc_list'],
        );
        users.add(data);
        index++;
      }
    }
    setState(() {
      filteredUser1 = users;
      // itemDup = ["ECP3N"];
    });
    return users;
  }

  _reload() async {
    users = [];
    setState(() {});
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<Group>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: getEditGruop,
                child: const Text('แก้ไข'),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: const Text('ลบ'),
              ),
            ],
          );
        })) {
    }
  }

  Future getEditGruop() async {
    await Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => EditGroupScreen()));

    setState(() {});
  }

  Future getDeleteGruop() async {
    await Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => EditGroupScreen()));

    setState(() {});
  }

  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(20, (i) => "กลุ่ม: $i");

  List<String> itemDup = ["DDDDDDDDDDDDDDD", "dsdsdsdsdsds"];
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  void click() {
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("หน้าหลัก"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Ashish Rawat"),
              accountEmail: Text("ashishrawat2911@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("ข้อมูลผู้ใช้งาน"),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DetailUserScreen()));
              },
            ),
            ListTile(
              title: Text("เพิ่มกลุ่ม"),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddGroupScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                 onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.title.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
                controller: editingController;
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))));
                 }),
            ),
            Expanded(
                child: new FutureBuilder(
                    future: userDetails(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        print("SNAP");
                        print(snapshot);
                        return new Center(
                          child: new CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: filteredUser1.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Image.asset("images/group.png"),
                                  title: Text(
                                    filteredUser(
                                        filteredUser1[index].groupName),
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text("12-3343-44"),
                                  trailing: Icon(Icons.arrow_drop_down),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext) =>
                                                DocumentScreen(
                                                  valueFromHome: "xxxx",
                                                )));
                                  },
                                  onLongPress: () {
                                    _askedToLead();
                                  },
                                ),
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey.shade300,
                                )
                              ],
                            );
                          },
                        );
                      }
                    })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext) => AddGroupScreen()))
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

String filteredUser(String s) => s[0].toUpperCase() + s.substring(1);

class User {
  final int index;
  final String groupName;
  final String docList;

  User({
    this.index,
    this.groupName,
    this.docList,
  });
}
