import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uneeds/pages/OtpPage.dart';

import '../extra/FB_LocalFunctions.dart' as firebase_functions;
import '../widgets/customwidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumber = TextEditingController();
  final ffAuth = firebase_functions.FirebaseFunc();
  final timeOut = const Duration(minutes: 1);

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
    super.initState();
    print("+${selectedCountry.phoneCode}");
    Future<void>.delayed(
        const Duration(milliseconds: 100), _tryPasteCurrentPhone);
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      mobileNumber.text = extractLast10Digits(phone);
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
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

  void onGetOTPClicked() async {
    String phoneNumber = "+${selectedCountry.phoneCode}${mobileNumber.text}";
    if (mobileNumber.text.length < 10) {
      print("Error");
    } else {
      ffAuth.phoneAuthentication(phoneNumber, timeOut).then((value) => {
            if (value != "")
              {
                //Navigator.pop(context),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OtpPage(
                      userPhoneNumber: phoneNumber,
                      otpVerificationId: value,
                      otpTimeout: const Duration(seconds: 30),
                    ),
                  ),
                )
              }
          });
    }
  }

  void onGoogleSignIn() {
    ffAuth.googleAuthentication().then((value) => {
          if (value != null)
            {
              print("Logged in as ${value.displayName}"),
            }
        });
  }

  void onTCClicked() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome! Let's get started!",
                          style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Verify your account with OTP.",
                          style: TextStyle(
                            color: Color(0xFF808080),
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextFieldA(
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
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          hintText: "Enter Mobile Number",
                          controller: mobileNumber,
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            onGetOTPClicked();
                          },
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
                            "Get OTP",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: const Text(
                        'or register / login using',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8C8E99),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageButtonHolder(
                          imagePath: 'assets/images/Icons/googlelogo.png',
                          onPressed: () {
                            onGoogleSignIn();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'By logging in, you agree to our\n',
                              style: TextStyle(
                                color: Color(0xFF8C8E99),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => onTCClicked(),
                            ),
                            const TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Color(0xFF8C8E99),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => print("Privacy Policy"),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
