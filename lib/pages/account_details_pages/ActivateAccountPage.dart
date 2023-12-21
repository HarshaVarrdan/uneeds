import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/pages/HomePage.dart';
import 'package:uneeds/pages/account_details_pages/BankDetailsPage.dart';
import 'package:uneeds/pages/account_details_pages/DocumentsPage.dart';
import 'package:uneeds/pages/account_details_pages/OptionsPage.dart';
import 'package:uneeds/pages/account_details_pages/UserDetails.dart';
import 'package:uneeds/widgets/CustomWidgets.dart';

class ActivateAccountPage extends StatefulWidget {
  const ActivateAccountPage({super.key});

  @override
  State<ActivateAccountPage> createState() => _ActivateAccountPageState();
}

class _ActivateAccountPageState extends State<ActivateAccountPage> {
  Map<String, bool> CompletedTasks = {
    "UserInformation": false,
    "Documents": false,
    "BankDetails": false,
    "Services": false,
  };

  void setValue(Map map, String boolName, bool value) {
    setState(() {
      map[boolName] = value;
    });
  }

  void onContinueClicked() async {
    if (CompletedTasks.values.every((value) => value == true)) {
      if (await BackendFunctions().addExpert(
          SharedPrefs().expertName,
          SharedPrefs().expertDOB.toString(),
          SharedPrefs().expertEID,
          SharedPrefs().expertGender,
          SharedPrefs().expertMobileNumber,
          SharedPrefs().expertJobs,
          context)) {
        SharedPrefs().detailsFilled = true;
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (SharedPrefs().expertEID == FirebaseAuth.instance.currentUser?.uid) {
      if (SharedPrefs().expertName != "" &&
          SharedPrefs().expertDOB.toString() != "" &&
          SharedPrefs().expertGender != "" &&
          SharedPrefs().expertMobileNumber != "") {
        CompletedTasks["UserInformation"] = true;
      }
      if (SharedPrefs().expertJobs != []) {
        CompletedTasks["Services"] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      appBar: CustomAppBar(
        PageName:
            "Account Details (${CompletedTasks.values.where((value) => value == true).length}/5)",
        context: context,
        leadingBool: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Theme.of(context).colorScheme.primary,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TaskPageOptions(
                title: "Your Information",
                value: CompletedTasks["UserInformation"]!,
                onValueChange: () async {
                  setValue(
                      CompletedTasks,
                      "UserInformation",
                      await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserDetailsPage()),
                          ) ??
                          false);
                },
              ),
              const SizedBox(height: 20),
              TaskPageOptions(
                title: "Your Services",
                value: CompletedTasks["Services"]!,
                onValueChange: () async {
                  setValue(
                      CompletedTasks,
                      "Services",
                      await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OptionsPage()),
                          ) ??
                          false);
                },
              ),
              const SizedBox(height: 20),
              TaskPageOptions(
                title: "Documents",
                value: CompletedTasks["Documents"]!,
                onValueChange: () async {
                  setValue(
                      CompletedTasks,
                      "Documents",
                      await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DocumentsPage()),
                          ) ??
                          false);
                },
              ),
              const SizedBox(height: 20),
              TaskPageOptions(
                title: "Bank Details",
                value: CompletedTasks["BankDetails"]!,
                onValueChange: () async {
                  setValue(
                      CompletedTasks,
                      "BankDetails",
                      await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BankDetailsPage()),
                          ) ??
                          false);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: TextButton(
          onPressed: onContinueClicked,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondary),
            fixedSize: MaterialStatePropertyAll(Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 12)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: const Text(
            "Continue",
            style: TextStyle(
              fontFamily: "DMSans",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
