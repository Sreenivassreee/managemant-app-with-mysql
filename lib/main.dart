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
  Future<List<Model>> people;
  String selected;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  void initState() {
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
    people = Services.Data();
    print(people);
  }

  _Add() {
    Services.add(firstName.text, lastName.text).then((value) {
      if (value == '    Sucess') {
        print("SucessFully Added");
      } else if (value == '    Failed') {
        print("Failed  To Added");
      }
    });
  }

  _Update() {
    Services.updage(selected, firstName.text, lastName.text).then((value) {
      if (value == '    Sucess') {
        print("SucessFully Added");
      } else if (value == '    Failed') {
        print("Failed  To Added");
      }
    });
  }

  _Delete() {
    Services.delete(selected).then((value) {
      if (value == '    Sucess') {
        print("SucessFully Deleted");
      } else if (value == '    Failed') {
        print("Failed  To Delete");
      }
    });
  }

  _clearText() {
    firstName.text = "";
    lastName.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _Add();
          _clearText();
        },
      ),
      appBar: AppBar(
        title: Text("Information About Employees"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _Data),
          IconButton(icon: Icon(Icons.add), onPressed: _create),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: firstName,
              decoration: InputDecoration(labelText: "FirstName"),
            ),
            TextField(
              controller: lastName,
              decoration: InputDecoration(labelText: "LastName"),
            ),
          ],
        ),
      ),
    );
  }
}
