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
    home: HomeScreen5(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen5();
  }
}

class _HomeScreen5 extends State {
  String filteredUser(String s) => s[0].toUpperCase() + s.substring(1);

  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = "http://www.mocky.io/v2/5ddffdf73500002863480a76";
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      print(notesJson['results']);
      print(response.body);
      for (var noteJson in notesJson['results']) {
        print(noteJson['group_name']);
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
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

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : _listItem(index - 1);
        },
        itemCount: _notesForDisplay.length + 1,
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

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.groupName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return new Column(
      children: <Widget>[
        ListTile(
          leading: Image.asset("images/group.png"),
          title: Text(
            "${_notesForDisplay[index].groupName}",
            style: new TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("12-3343-44"),
          trailing: Icon(Icons.arrow_drop_down),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext) => DocumentScreen(
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
  }
}

class Note {
  String groupName;

  Note(this.groupName);

  Note.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
  }
}
