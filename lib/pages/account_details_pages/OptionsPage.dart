import 'package:flutter/material.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/widgets/customwidgets.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  int currentPageIndex = 0;

  late List<String> selectedJobs = [];

  Map<String, bool> selectedItemsA = {
    'Individual': false,
    'Business': false,
  };

  Map<String, bool> selectedItemsB = {
    'Electrician': false,
    'Plumber': false,
    'AC Mechanic': false,
    'Carpenter': false,
  };

  Container questionContainer() {
    final container = [
      Container(
        color: Theme.of(context).colorScheme.primary,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const Image(
                    image: AssetImage("assets/images/service_logo.png"),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "How would you like to join us?",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "Individual",
                  imagePath: "",
                  value: selectedItemsA["Individual"]!,
                  onValueChange: (value) {
                    print(
                        "Individual ${selectedItemsA["Individual"]} ${value}");
                    setValue(selectedItemsA, "Individual", value);
                    print("Business ${selectedItemsA["Business"]} ${!value}");
                    setValue(selectedItemsA, "Business", !value);
                  },
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "Business",
                  imagePath: "",
                  value: selectedItemsA["Business"]!,
                  onValueChange: (value) {
                    print(
                        "Individual ${selectedItemsA["Individual"]} ${!value}");
                    setValue(selectedItemsA, "Individual", !value);
                    print("Business ${selectedItemsA["Business"]} ${value}");
                    setValue(selectedItemsA, "Business", value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Theme.of(context).colorScheme.primary,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const Image(
                    image: AssetImage("assets/images/service_logo.png"),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "How would you like to join us?",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "Electrician",
                  imagePath: "assets/images/electrical.png",
                  value: selectedItemsB["Electrician"]!,
                  onValueChange: (bool value) {
                    setValue(selectedItemsB, "Electrician", value);
                  },
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "Plumber",
                  imagePath: "assets/images/plumbing.png",
                  value: selectedItemsB["Plumber"]!,
                  onValueChange: (bool value) {
                    setValue(selectedItemsB, "Plumber", value);
                  },
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "Carpenter",
                  imagePath: "assets/images/carpentry.png",
                  value: selectedItemsB["Carpenter"]!,
                  onValueChange: (bool value) {
                    setValue(selectedItemsB, "Carpenter", value);
                  },
                ),
                const SizedBox(height: 20),
                InfoPageOptions(
                  title: "AC Mechanic",
                  imagePath: "assets/images/ac_service.png",
                  value: selectedItemsB["AC Mechanic"]!,
                  onValueChange: (bool value) {
                    setValue(selectedItemsB, "AC Mechanic", value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ];
    return container[currentPageIndex];
  }

  void setValue(Map map, String boolName, bool value) {
    setState(() {
      map[boolName] = value;
    });
  }

  void onContinueClicked() {
    if (currentPageIndex == 0) {
      setState(() {
        currentPageIndex += 1;
      });
    } else {
      selectedItemsB.forEach((key, value) {
        if (value) {
          selectedJobs.add(key);
          SharedPrefs().expertJobs = selectedJobs;
        }
      });

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () async {
                if (currentPageIndex > 0) {
                  setState(() {
                    currentPageIndex -= 1;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 50,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(child: questionContainer()),
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
