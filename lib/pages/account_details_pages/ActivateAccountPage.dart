import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/pages/HomePage.dart';
import 'package:uneeds/pages/account_details_pages/OptionsPage.dart';
import 'package:uneeds/pages/account_details_pages/UserDetails.dart';
import 'package:uneeds/widgets/customwidgets.dart';

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
          SharedPrefs().userMobileNumber,
          SharedPrefs().expertJobs)) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Complete all the steps to Activate your account (2/5)",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  TaskPageOptions(
                    title: "Your Information",
                    imagePath: "assets/images/electrical.png",
                    value: CompletedTasks["UserInformation"]!,
                    onValueChange: () async {
                      setValue(
                          CompletedTasks,
                          "UserInformation",
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserDetailsPage()),
                          ));
                    },
                  ),
                  const SizedBox(height: 20),
                  TaskPageOptions(
                    title: "Your Services",
                    imagePath: "assets/images/electrical.png",
                    value: CompletedTasks["Services"]!,
                    onValueChange: () async {
                      setValue(
                          CompletedTasks,
                          "Services",
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OptionsPage()),
                          ));
                    },
                  ),
                  const SizedBox(height: 20),
                  TaskPageOptions(
                    title: "Documents",
                    imagePath: "assets/images/plumbing.png",
                    value: CompletedTasks["Documents"]!,
                    onValueChange: () {
                      //setValue(CompletedTasks, "Documents", value);
                    },
                  ),
                  const SizedBox(height: 20),
                  TaskPageOptions(
                    title: "Bank Details",
                    imagePath: "assets/images/carpentry.png",
                    value: CompletedTasks["BankDetails"]!,
                    onValueChange: () {
                      //setValue(CompletedTasks, "BankDetails", value);
                    },
                  ),
                ],
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
