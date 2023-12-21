import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:camera/camera.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:uneeds/extra/Common_Functions.dart';
import 'package:uneeds/extra/Location_Functions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/pages/CameraPage.dart';
import 'package:uneeds/widgets/CustomWidgets.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String DOB = "DD/MM/YY";

  TextEditingController expertNameC = TextEditingController();
  TextEditingController expertDOBC = TextEditingController();
  TextEditingController expertMobileNumberC = TextEditingController();
  TextEditingController expertLocAreaC = TextEditingController();
  TextEditingController expertLocStateC = TextEditingController();
  late String userGender = "M";

  late Map<String, String> _currentAddress;
  late Position _currentPosition;
  Map<String, dynamic> locationDetails = {};

  late File _image = File("");

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

  void onContinueClicked() {
    if (expertMobileNumberC.text != "" &&
        expertDOBC.text != "" &&
        expertNameC.text != "" &&
        expertLocAreaC.text != "" &&
        expertLocStateC.text != "" &&
        userGender != "" &&
        _image.path != "") {
      SharedPrefs().expertEID = _auth.currentUser?.uid ?? "";
      SharedPrefs().expertName = expertNameC.text;
      SharedPrefs().expertMobileNumber = expertMobileNumberC.text;
      SharedPrefs().expertDOB = expertDOBC.text;
      SharedPrefs().expertGender = userGender;

      Navigator.pop(context, true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    expertMobileNumberC.text = CommonFunctions()
        .extractLast10Digits(_auth.currentUser?.phoneNumber ?? "");

    CommonFunctions().extractLast10Digits(_auth.currentUser?.phoneNumber ?? "");

    if (SharedPrefs().expertEID == _auth.currentUser?.uid) {
      expertDOBC.text = SharedPrefs().expertDOB.toString();
      userGender = SharedPrefs().expertGender;
      expertNameC.text = SharedPrefs().expertName;
    }

    LocationFunctions().getCurrentPosition(context).then((result) {
      if (!result.containsKey("error") && result.isNotEmpty) {
        setState(() {
          locationDetails = result;
          _currentAddress = locationDetails["Address"] as Map<String, String>;
          _currentPosition = locationDetails["Position"];
          expertLocAreaC.text = _currentAddress["subLocality"]!;
          expertLocStateC.text = _currentAddress["subAdministrationArea"]!;
        });
      } else {
        print(result);
      }
    });
    print(_image.path);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    expertLocStateC.dispose();
    expertLocAreaC.dispose();
    expertNameC.dispose();
    expertDOBC.dispose();
    expertMobileNumberC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        PageName: "Enter Details",
        context: context,
        defaultReturn: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                      onTap: () async {
                        final cameras = await availableCameras();

                        final tempImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraPage(
                                      camera: cameras[1],
                                    )));
                        //await CommonFunctions().getImage();
                        //await Navigator.push(context,MaterialPageRoute(builder: (context) => CameraPage(camera: cameras[1],)));
                        setState(() {
                          _image = File(tempImage!.path);
                        });
                        print(_image);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF202020),
                            width: 1,
                          ),
                          //borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: _image.path != ""
                              ? ClipOval(
                                  child: Image.file(
                                    _image,
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
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
                  controller: expertNameC,
                  labelText: "Full Name",
                  onChanged: (value) {},
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
                  controller: expertMobileNumberC,
                  labelText: "Mobile Number",
                  onChanged: (value) {},
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
                            config: CalendarDatePicker2WithActionButtonsConfig(
                                selectedDayHighlightColor:
                                    Theme.of(context).colorScheme.secondary),
                            dialogSize: const Size(325, 400),
                            borderRadius: BorderRadius.circular(15),
                          );
                          setState(() {
                            expertDOBC.text = selectedDOB.toString() == "null"
                                ? "DD/MM/YYYY"
                                : DateFormat('dd/MM/yyyy')
                                    .format(selectedDOB![0] ?? DateTime.now())
                                    .toString();
                          });
                        },
                        child: CustomDOBField(
                          hintText: expertDOBC.text,
                          labelText: "DOB",
                          valueSelected: expertDOBC.text == "DD/MM/YYYY" ||
                                  expertDOBC.text == ""
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
                        values: ["M", "F"],
                        onValueChange: (String value) {
                          userGender = value;
                        },
                        hintText: 'Gender',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextFieldB(
                  readOnly: true,
                  hintText: "Location",
                  controller: expertLocAreaC,
                  labelText: "Area",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                CustomTextFieldB(
                  readOnly: true,
                  hintText: "Location",
                  controller: expertLocStateC,
                  labelText: "State",
                  onChanged: (value) {},
                ),
              ],
            ),
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
