import 'package:management_app/model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {
  static String ROOT = "http://192.168.64.2/Management/script.php";
  static String CREATE_TABLE_ACTION = 'CreateDb';
  static String ADD_EMPLOYE_ACTION = 'Add';
  static String UPDATE_ACTION = 'update';
  static String GET_ACTION = 'get';
  static String DELETE_ACTION = 'delete';
  List<Model> list;

  static List<Model> parseData(String parsedData) {
    final data = jsonDecode(parsedData).cast<Map<String, dynamic>>();
    return data.map<Model>((json) => Model.fromJson(json)).toList();
  }

  static Future<List<Model>> Data() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ACTION;
      final responce = await http.post(ROOT, body: map);
      if (200 == responce.statusCode) {
        List<Model> list = parseData(responce.body);
        return list;
      } else {
        return List<Model>();
      }
    } catch (e) {
      return List<Model>();
    }
  }

  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CREATE_TABLE_ACTION;

      var responce = await http.post(ROOT, body: map);

      print("${responce.body}");

      if (responce.statusCode == 200) {
        return responce.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }

  static Future<String> add(String first, String last) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ADD_EMPLOYE_ACTION;
      map['firstName'] = first;
      map['lastName'] = last;

      var responce = await http.post(ROOT, body: map);

      print("responce.body : ${responce.body}");

      if (responce.statusCode == 200) {
        return responce.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }

  static Future<String> updage(String emp_id, String first, String last) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_ACTION;
      map['emp_id'] = emp_id;
      map['firstName'] = first;
      map['lastName'] = last;

      var res = await http.post(ROOT, body: map);

      print("UPdate Responce : ${res.body}");
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }

  static Future<String> delete(String emp_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_ACTION;

      var res = await http.post(ROOT, body: map);
      print("Delete Responce : ${res.body}");
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }
}
