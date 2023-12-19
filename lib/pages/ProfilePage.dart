import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/pages/OnBoardingPage.dart';
import 'package:uneeds/widgets/customwidgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              SettingsCardsA(
                onTap: () {
                  Navigator.pushNamed(context, "/servicehistorypage");
                },
              ),
              SettingsCardsB(
                CardName: 'Account',
                CardDesc: 'Contact Details, Password',
                onTap: () {},
                CardIconLoc: 'assets/images/account.png',
              ),
              SettingsCardsB(
                CardName: 'Payments',
                CardDesc: 'Bank Account Details',
                onTap: () {},
                CardIconLoc: 'assets/images/bank.png',
              ),
              SettingsCardsB(
                CardName: 'Documents',
                CardDesc: 'Aadhaar Card, PAN Card',
                onTap: () {},
                CardIconLoc: 'assets/images/document.png',
              ),
              SettingsCardsB(
                CardName: 'Policies',
                CardDesc: 'View Terms and Condition, Privacy Policy',
                onTap: () {},
                CardIconLoc: 'assets/images/policy.png',
              ),
              SettingsCardsB(
                CardName: 'LogOut',
                CardDesc: 'LogOut of your account.',
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnBoardingPage()));
                },
                CardIconLoc: 'assets/images/logout.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
