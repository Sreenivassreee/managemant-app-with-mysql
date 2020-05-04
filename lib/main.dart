import 'package:flutter/material.dart';
import 'package:management_app/services.dart';

import 'model.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Management wtih Sql",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model> model;
  String selected;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    _Data();
    super.initState();
  }

  _create() {
    Services.createTable().then((result) {
      if (result == '    Sucess') {
        print("SuceessFully Created");
      } else if (result == '    Failed') {
        print("Failed to create");
      }
    });
  }

  _Data() {
    Services.Data().then((people) {
      setState(() {
        print("people$people");
        model = people;
      });
      print(model[2].firstName);
    });
  }

  _Add() {
    Services.add(firstNameController.text, lastNameController.text)
        .then((value) {
      if (value == '    Sucess') {
        print("SucessFully Added");
        _Data();
      } else if (value == '    Failed') {
        print("Failed  To Added");
      }
    });
  }

  _Update(id) {
    Services.updage(id, firstNameController.text, lastNameController.text)
        .then((value) {
      if (value == '    Sucess') {
        print("SucessFully Added");
      } else if (value == '    Failed') {
        print("Failed  To Added");
      }
    });
  }

  _Delete(selected) {
    Services.delete(selected).then((value) {
      _Data();
      if (value == '    Sucess') {
        print("SucessFully Deleted");
      } else if (value == '    Failed') {
        print("Failed  To Delete");
      }
    });
  }

  _clearText() {
    firstNameController.text = "";
    lastNameController.text = "";
  }

  showText(Model e) {
    setState(() {
      firstNameController.text = e.firstName;
      lastNameController.text = e.lastName;
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            _Update(selected);
            _clearText();
            _Data();
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _Add();
            _clearText();
          },
        ),
      ]),
      appBar: AppBar(
        title: Text("Information About Employees"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _Data),
          IconButton(icon: Icon(Icons.add), onPressed: _create),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: "FirstName"),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: "LastName"),
                ),
              ],
            ),
          ),
          Flexible(
            child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('FirstName')),
                DataColumn(label: Text('LastClass')),
                DataColumn(label: Text('Delete')),
              ],
              rows: model
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(
                        Text(
                          e.id,
                        ),
                        onTap: () {
                          selected = e.id;
                          showText(e);
                        },
                      ),
                      DataCell(
                        Text(
                          e.firstName,
                        ),
                        onTap: () {
                          selected = e.id;
                          showText(e);
                        },
                      ),
                      DataCell(
                        Text(
                          e.lastName,
                        ),
                        onTap: () {
                          selected = e.id;
                          showText(e);
                        },
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _Delete(e.id);
                          },
                        ),
                      ),
                    ]),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
