import 'package:flutter/material.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/pages/EarningsPage.dart';
import 'package:uneeds/pages/ProfilePage.dart';
import 'package:uneeds/pages/TicketsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 1;

  bool Discover = true;

  late TabController jobsTabC;

  AppBar CustomAppBars(int index) {
    List<AppBar> CustomAppBar = [
      AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: const Text(
          "Jobs",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 10),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextButton(
                        onPressed: () {
                          changeBoolValue();
                        },
                        child: Text("Discover",
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Discover
                                          ? Colors.white
                                          : const Color(0x66FFFFFF),
                                      offset: const Offset(0, -5))
                                ],
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.transparent,
                                decoration:
                                    Discover ? TextDecoration.underline : null,
                                decorationColor: Colors.white,
                                decorationThickness: 2)),
                      ),
                    ),
                    const VerticalDivider(
                      width: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 5,
                      color: Colors
                          .white, // Change this color to make the divider visible
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextButton(
                        onPressed: () {
                          changeBoolValue();
                        },
                        child: Badge(
                          offset: Offset.fromDirection(100, 20),
                          isLabelVisible: true,
                          backgroundColor: const Color(0xFFD9D9D9),
                          textColor: Theme.of(context).colorScheme.secondary,
                          child: Text("Accepted",
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: !Discover
                                            ? Colors.white
                                            : const Color(0x66FFFFFF),
                                        offset: const Offset(0, -5))
                                  ],
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.transparent,
                                  decoration: !Discover
                                      ? TextDecoration.underline
                                      : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2)),
                          label: const Text("1"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height / 10) / 7.5),
              const Row(
                children: [
                  SizedBox(width: 20),
                  ImageIcon(
                    AssetImage(
                      "assets/images/location_dark.png",
                    ),
                    size: 15,
                    color: Color(0xFFD9D9D9),
                  ),
                  Text(
                    "Muthialpet, Pondicherry",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFFD9D9D9)),
                  )
                ],
              ),
              SizedBox(height: (MediaQuery.of(context).size.height / 10) / 10),
            ],
          ),
        ),
      ),
      AppBar(
        centerTitle: true,
        title: const Text(
          "My Earnings",
          style: TextStyle(
              fontFamily: "DMSans",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6440FE),
        elevation: 0,
      ),
      AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: const Text(
          "Jobs",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 10),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                    ),
                    const SizedBox(width: 7),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          SharedPrefs().expertName,
                          style: const TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              SharedPrefs().expertRating.toString(),
                              style: const TextStyle(
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return CustomAppBar[index];
  }

  void changeBoolValue() {
    setState(() {
      Discover = !Discover;
    });
  }

  void changeScreen(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobsTabC = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBars(currentIndex),
      body: IndexedStack(
        index: currentIndex,
        children: [
          TicketsPage(
            Discover: Discover,
          ),
          const EarningsPage(),
          const ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          changeScreen(index);
        },
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/repair_off.png",
              width: 50,
            ),
            label: "Tickets",
            activeIcon: Image.asset(
              "assets/images/repair_on.png",
              width: 50,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/earnings_off.png",
              width: 50,
            ),
            label: "My Earnings",
            activeIcon: Image.asset(
              "assets/images/earnings_on.png",
              width: 50,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/settings_off.png",
              width: 50,
            ),
            label: "Settings",
            activeIcon: Image.asset(
              "assets/images/settings_on.png",
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
