import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/widgets/CustomWidgets.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController aadharNumberC = TextEditingController();
  final TextEditingController panNumberC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onContinueClicked() {
    Navigator.pop(context, true);
    //Navigator.pushReplacement(context,
    //MaterialPageRoute(builder: (context) => const OptionsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        PageName: "Documents",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                "The updated Details will be Verified and updated within 48hours",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aadhar Card",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldB(
                        hintText: "Your Aadhar Card Number",
                        controller: aadharNumberC,
                        labelText: "Aadhar Number"),
                    SizedBox(height: 10),
                    SecondaryFileButton(
                      buttonTitle: "Aadhar Card - Front",
                      upload: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    SecondaryFileButton(
                      buttonTitle: "Aadhar Card - Back",
                      upload: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PAN Card",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldB(
                        hintText: "Your PAN Card Number",
                        controller: panNumberC,
                        labelText: "PAN Number"),
                    SizedBox(height: 10),
                    SecondaryFileButton(
                      buttonTitle: "PAN Card - Front",
                      upload: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    SecondaryFileButton(
                      buttonTitle: "PAN Card - Back",
                      upload: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
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
