import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/detail_user.dart';
import 'package:mobile_docmenagement/document.dart';
import 'package:mobile_docmenagement/add_group.dart';
import 'package:mobile_docmenagement/edit_group.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State {
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => EditGroupScreen()));
    ;

    setState(() {});
  }

  Future getDeleteGruop() async {
    await Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => EditGroupScreen()));
    ;

    setState(() {});
  }

  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(20, (i) => "กลุ่ม: $i");
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
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset("images/group.png"),
                      title: Text("${items[index]}"),
                      subtitle: Text("12-3343-44"),
                      trailing: Icon(Icons.arrow_drop_down),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentScreen(),
                          ),
                        );
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
            )),
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

class Group {}
