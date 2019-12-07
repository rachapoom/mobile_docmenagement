import 'package:flutter/material.dart';
import 'package:mobile_docmenagement/detail_document.dart';
import 'package:mobile_docmenagement/add_document.dart';
import 'package:mobile_docmenagement/edit_document.dart';
import 'package:mobile_docmenagement/test3.dart';

void main() {
  runApp(MaterialApp(
    home: DocumentScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class DocumentScreen extends StatefulWidget {
  final String valueFromHome;
  DocumentScreen({Key key, this.valueFromHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DocumentScreen(this.valueFromHome);
  }
}

class _DocumentScreen extends State {
   String valueFromHome;
  _DocumentScreen(this.valueFromHome);

  Future<void> _askedToLead() async {
    switch (await showDialog<Doc>(
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
        builder: (BuildContext context) => EditDocumentScreen()));

    setState(() {});
  }

  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(20, (i) => "เอกสาร: $i");
  var items = List<String>();

  @override
  void initState() {
   
    print(valueFromHome);
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
    var valueFromHome;
    return Scaffold(
      appBar: AppBar(
        title: Text("หน้าเอกสาร"),
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
                        leading: Image.asset("images/document.png"),
                        title: Text(
                          "${items[index]}",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("12-3343-44"),
                        trailing: Icon(Icons.arrow_drop_down),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDocumentScreen(),
                            ),
                          );
                        },
                        onLongPress: () {
                          _askedToLead();
                        }),
                    Divider(
                      height: 2.0,
                      color: Colors.grey.shade300,
                    ),
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
              MaterialPageRoute(builder: (BuildContext) => AddDocumentScreen()))
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class Doc {}
