import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/widgets/customwidgets.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String DOB = "DD/MM/YY";

  TextEditingController userNameC = TextEditingController();
  TextEditingController userDOBC = TextEditingController();
  TextEditingController userMobileNumberC = TextEditingController();
  late String userGender;

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "INDIA",
      example: "INDIA",
      displayName: "INDIA",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (SharedPrefs().expertEID != _auth.currentUser?.uid) {
      userMobileNumberC.text =
          extractLast10Digits(_auth.currentUser?.phoneNumber ?? "");
      userDOBC.text = SharedPrefs().expertDOB;
      userGender = SharedPrefs().expertGender;
      userNameC.text = SharedPrefs().expertName;
    }
  }

  String extractLast10Digits(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length >= 10) {
      return digitsOnly.substring(digitsOnly.length - 10);
    } else {
      return digitsOnly;
    }
  }

  void onContinueClicked() {
    if (userMobileNumberC.text != "" &&
        userDOBC.text != "" &&
        userNameC.text != "" &&
        userGender != "") {
      SharedPrefs().expertEID = _auth.currentUser?.uid ?? "";
      SharedPrefs().expertName = userNameC.text;
      SharedPrefs().expertMobileNumber = userMobileNumberC.text;
      SharedPrefs().expertDOB = userDOBC.text;
      SharedPrefs().expertGender = userGender;

      Navigator.pop(context, true);
      //Navigator.pushReplacement(context,
      //MaterialPageRoute(builder: (context) => const OptionsPage()));
    }
  }

  bool canShowContinue() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 10),
          child: const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Center(
              child: Text(
                "Enter Details",
                style: TextStyle(
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF202020),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/camera.png"),
                              size: 40,
                            ),
                            Text(
                              "Add Selfie",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF202020)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFieldB(
                hintText: "Your Full Name",
                controller: userNameC,
                labelText: "Full Name",
                onChanged: (value) {
                  canShowContinue();
                },
              ),
              const SizedBox(height: 10),
              CustomTextFieldB(
                readOnly: true,
                prefix: InkWell(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        onSelect: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        });
                  },
                  child: Text(
                    "+${selectedCountry.phoneCode}",
                    style: const TextStyle(
                      color: Color(0xFF151617),
                      fontSize: 15,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                hintText: "01234567890",
                controller: userMobileNumberC,
                labelText: "Mobile Number",
                onChanged: (value) {
                  canShowContinue();
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        List<DateTime?>? selectedDOB =
                            await showCalendarDatePicker2Dialog(
                          context: context,
                          config: CalendarDatePicker2WithActionButtonsConfig(),
                          dialogSize: const Size(325, 400),
                          borderRadius: BorderRadius.circular(15),
                        );
                        setState(() {
                          userDOBC.text = selectedDOB.toString() == "null"
                              ? "DD/MM/YYYY"
                              : DateFormat('dd/MM/yyyy')
                                  .format(selectedDOB![0] ?? DateTime.now())
                                  .toString();
                        });
                      },
                      child: CustomDOBField(
                        hintText: userDOBC.text,
                        labelText: "DOB",
                        valueSelected:
                            userDOBC.text == "DD/MM/YYYY" || userDOBC.text == ""
                                ? false
                                : true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomDropdownMenu(
                      values: ["Male", "Female"],
                      onValueChange: (String value) {
                        userGender = value;
                      },
                      hintText: 'Gender',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: canShowContinue()
          ? Container(
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
            )
          : null,
    );
  }
}
