import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/extra/Common_Functions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/pages/HomePage.dart';
import 'package:uneeds/pages/account_details_pages/ActivateAccountPage.dart';

import '../extra/FB_LocalFunctions.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key,
      required this.userPhoneNumber,
      required this.otpVerificationId,
      required this.otpTimeout});

  final String userPhoneNumber;
  final String otpVerificationId;
  final Duration otpTimeout;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFunc ffAuth = FirebaseFunc();

  final Duration timerTiming = const Duration(minutes: 1);
  late Timer _timer;
  bool _timerActive = false;
  bool canResendOTP = false;

  String otp = "";
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the timer with a duration of 60 seconds (adjust as needed)
    _startTimer(widget.otpTimeout);
  }

  void _startTimer(Duration duration) {
    _timerActive = true;
    _remainingSeconds =
        duration.inSeconds; // Set the initial remaining seconds.

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // Update the remaining seconds every second.
      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          _timerActive = false;
          canResendOTP = true;
        });
      }
    });
  }

  void _resendOTP() {
    // Implement your resend OTP logic here
    if (canResendOTP) {
      ffAuth.phoneAuthentication(widget.userPhoneNumber, timerTiming);
      setState(() {
        canResendOTP = !canResendOTP;
      });
    }
    // For example, restart the timer
    if (!_timerActive) {
      _startTimer(timerTiming);
      // Trigger the OTP resend logic here
    }
  }

  void verifyOTP(BuildContext context) async {
    otp = "";
    for (int i = 0; i < _controllers.length; i++) {
      otp = otp + _controllers[i].text;
    }
    print(otp);
    ffAuth.phoneVerification(widget.otpVerificationId, otp).then(
          (value) => {
            if (value != null)
              {
                print(auth.currentUser?.uid.toString()),
                BackendFunctions()
                    .checkExpert(
                        auth.currentUser?.uid.toString() ?? "", context)
                    .then(
                      (data) => {
                        if (data['exists'])
                          {
                            print(data['expertdetails']),
                            SharedPrefs().expertEID =
                                auth.currentUser?.uid.toString() ?? "",
                            SharedPrefs().setValuesFromDB(
                                SharedPrefs().expertEID, context),
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()))
                          }
                        else
                          {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ActivateAccountPage()))
                          }
                      },
                    ),
              }
            else
              {
                CommonFunctions()
                    .showMessageSnackBar("Wrong Otp ! Try Again !", context)
              }
          },
        );
  }

  @override
  void dispose() {
    for (var i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              //width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "OTP Verification",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Enter the verification code sent to ',
                              style: TextStyle(
                                color: Color(0xFF808080),
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: widget.userPhoneNumber.toString(),
                              style: const TextStyle(
                                color: Color(0xFF151617),
                                fontSize: 16,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 12,
                            //color: Colors.redAccent,
                            child: TextField(
                              controller: _controllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              focusNode: _focusNodes[index],
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (index < 5) {
                                    _focusNodes[index].unfocus();
                                    _focusNodes[index + 1].requestFocus();
                                  } else {
                                    _focusNodes[index].unfocus();
                                  }
                                }
                                _controllers[index].addListener(
                                  () {
                                    if (_controllers[index].text.isEmpty) {
                                      if (index > 0) {
                                        _focusNodes[index].unfocus();
                                        _focusNodes[index - 1].requestFocus();
                                      }
                                    }
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 1),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF151617),
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: const Color(0xFF151617),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          verifyOTP(context);
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
                          "Verify",
                          style: TextStyle(
                            fontFamily: "DMSans",
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
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Didn\'t you receive the OTP? ',
                      style: TextStyle(
                        color: Color(0xFF7E7E7E),
                        fontSize: 15,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: _remainingSeconds == 0
                          ? "Resend OTP"
                          : "Resend OTP ($_remainingSeconds)",
                      style: TextStyle(
                        color: canResendOTP
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.black12,
                        fontSize: 15,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _resendOTP(),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
