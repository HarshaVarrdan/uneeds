import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/pages/HomePage.dart';
import 'package:uneeds/pages/Login.dart';
import 'package:uneeds/pages/OnBoardingPage.dart';
import 'package:uneeds/pages/account_details_pages/OptionsPage.dart';
import 'package:uneeds/pages/settings%20pages/JobHistoryPage.dart';

import 'extra/SaveUserPreference.dart';

void main() async {
  late final landingScene;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs().init();

  print(FirebaseAuth.instance.currentUser?.uid);
  BackendFunctions().checkConnection(null);

  if (FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.currentUser?.uid == SharedPrefs().expertEID &&
            SharedPrefs().detailsFilled
        ? {
            landingScene = const HomePage(),
            SharedPrefs().setValuesFromDB(
                FirebaseAuth.instance.currentUser?.uid ??
                    SharedPrefs().expertEID,
                null)
          }
        : {
            FirebaseAuth.instance.signOut(),
            SharedPrefs().resetValues(),
            landingScene = const LoginPage(),
          };
  } else {
    SharedPrefs().resetValues();
    landingScene = const LoginPage();
  }

  runApp(MaterialApp(
    title: "UNeeds",
    theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.white,
          secondary: const Color(0xFF6440FE),
          tertiary: const Color(0xFFC7C9D9),
          background: Color(0xFFF5F5F7),
          // ···
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme()),
    home: landingScene,
    initialRoute: '/',
    routes: {
      '/optionspage': (context) => const OptionsPage(),
      '/loginpage': (context) => const LoginPage(),
      '/onboardingpage': (context) => const OnBoardingPage(),
      '/servicehistorypage': (context) => const JobHistoryPage(),
      //'/accountpage': (context) => const (),
      //'/paymentpage': (context) => const (),
      //'/documentspage': (context) => const (),
      //'/policiespage': (context) => const (),
    },
  ));
}
