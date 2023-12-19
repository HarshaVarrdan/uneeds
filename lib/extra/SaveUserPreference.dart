import 'dart:convert';

import 'package:native_shared_preferences/native_shared_preferences.dart';
import 'package:uneeds/extra/BackendFunctions.dart';

class SharedPrefs {
  late final NativeSharedPreferences _sharedPrefs;
  static final SharedPrefs _instance = SharedPrefs._internal();
  factory SharedPrefs() => _instance;
  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await NativeSharedPreferences.getInstance();
  }

  List<String> get expertJobs => _sharedPrefs.getStringList("ExpertJobs") ?? [];
  String get expertName => _sharedPrefs.getString("ExpertUsername") ?? "";
  String get userMobileNumber =>
      _sharedPrefs.getString("ExpertMobileNumber") ?? "";
  String get expertEID => _sharedPrefs.getString("ExpertEID") ?? "";
  String get expertGender => _sharedPrefs.getString("ExpertGender") ?? "";
  double get expertRating => _sharedPrefs.getDouble("ExpertRating") ?? 0.0;
  String get expertDOB => _sharedPrefs.getString("ExpertDOB") ?? "";

  set expertJobs(List<String> value) {
    _sharedPrefs.setStringList("ExpertJobs", value);
  }

  set expertName(String value) {
    _sharedPrefs.setString("ExpertUsername", value);
  }

  set expertMobileNumber(String value) {
    _sharedPrefs.setString("ExpertMobileNumber", value);
  }

  set expertEID(String value) {
    _sharedPrefs.setString("ExpertEID", value);
  }

  set expertGender(String value) {
    _sharedPrefs.setString("ExpertGender", value);
  }

  set expertRating(double value) {
    _sharedPrefs.setDouble("ExpertRating", value);
  }

  set expertDOB(String value) {
    _sharedPrefs.setString("ExpertDOB", value);
  }

  void setValuesFromDB(String currentEID) async {
    final data = await BackendFunctions().checkExpert(currentEID);

    if (data['exists']) {
      print(jsonDecode(data['expertdetails']['jobs']));
      List<String> jobTemp = [];
      List<dynamic> temp = jsonDecode(data['expertdetails']['jobs']);
      for (int i = 0; i < temp.length; i++) {
        jobTemp.add(temp[i].toString());
      }

      _sharedPrefs.setString(
          "ExpertUsername", data['expertdetails']["expert_name"]);
      _sharedPrefs.setString(
          "ExpertMobileNumber", data['expertdetails']["expert_mobilenumber"]);
      _sharedPrefs.setInt("ExpertDOB", data['expertdetails']["expert_dob"]);
      _sharedPrefs.setString("ExpertEID", data['expertdetails']["eid"]);
      _sharedPrefs.setString(
          "ExpertGender", data['expertdetails']["expert_gender"]);
      _sharedPrefs.setDouble("ExpertRating",
          double.parse(data['expertdetails']["expert_rating"].toString()));
      _sharedPrefs.setStringList("ExpertJobs", jobTemp);

      print(
          "${_sharedPrefs.getString("ExpertUsername")} \n${_sharedPrefs.getString("ExpertMobileNumber")}\n${_sharedPrefs.getInt("ExpertDOB")}\n${_sharedPrefs.getString("ExpertEID")}\n${_sharedPrefs.getStringList("ExpertJobs")}");
    }
  }

  void resetValues() {
    _sharedPrefs.setString("ExpertUsername", "");
    _sharedPrefs.setString("ExpertMobileNumber", "");
    _sharedPrefs.setInt("ExpertDOB", 0);
    _sharedPrefs.setString("ExpertEID", "");
    _sharedPrefs.setStringList("ExpertJobs", []);
  }

  void setTickets() {}
}
