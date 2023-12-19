import 'dart:convert';

import 'package:http/http.dart' as http;

class BackendFunctions {
  Future<bool> addExpert(
    String username,
    String dob,
    String eid,
    String gender,
    String mobilenumber,
    List<String> jobs,
  ) async {
    final Map<String, dynamic> body = {
      'username': username,
      'dob': dob,
      'eid': eid,
      'gender': gender,
      'mobilenumber': mobilenumber,
      'jobs': jobs,
    };

    print(
        "${body['username']} : ${body['dob']} : ${body['eid']} : ${body['mobilenumber']} : ${body['jobs']}");

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
      return false;
    }
  }

  Future<Map> checkExpert(String eid) async {
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
  }

  Future<void> checkConnection() async {
    final response = await http.get(
      Uri.parse('https://UNeeds.harshavarrdan.repl.co/checkConnection'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print("Connection Succesful");
      return;
    } else {
      throw Exception('Failed to check user existence');
    }
  }

  Future<List> getAllTickets() async {
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
  }
}
