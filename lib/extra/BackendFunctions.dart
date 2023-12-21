import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uneeds/extra/Common_Functions.dart';

class BackendFunctions {
  Future<bool> addExpert(String username, String dob, String eid, String gender,
      String mobilenumber, List<String> jobs, BuildContext context) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('https://UNeeds.harshavarrdan.repl.co/addExpert'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'dob': dob,
          'eid': eid,
          'gender': gender,
          'mobilenumber': mobilenumber,
          'jobs': jobs,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Expert added successfully. ExpertID: ${data['userId']}');
        return true;
      } else {
        print('Failed to add user. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error adding user: $error');
      CommonFunctions()
          .showMessageSnackBar("Error Adding User : $error", context);
      return false;
    }
  }

  Future<Map> checkExpert(String eid, BuildContext? context) async {
    try {
      final response = await http.post(
        Uri.parse('https://UNeeds.harshavarrdan.repl.co/checkExpert'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'eid': eid}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to check user existence');
      }
    } catch (error) {
      print('Error Checking user: $error');
      if (context != null)
        CommonFunctions()
            .showMessageSnackBar("Error Checking User : $error", context);

      return {};
    }
  }

  Future<void> checkConnection(BuildContext? context) async {
    try {
      final response = await http.get(
        Uri.parse('https://UNeeds.harshavarrdan.repl.co/checkConnection'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Connection Successful");
        return;
      } else {
        throw Exception('Failed to check user existence');
      }
    } catch (error) {
      print('Error Checking user: $error');
      if (context != null)
        CommonFunctions()
            .showMessageSnackBar("Error Checking User : $error", context);
    }
  }

  Future<List> getAllTickets(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('https://UNeeds.harshavarrdan.repl.co/getAllTickets'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data["result"];
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      print('Error Checking user: $error');
      CommonFunctions()
          .showMessageSnackBar("Error Checking User : $error", context);

      return [];
    }
  }
}
