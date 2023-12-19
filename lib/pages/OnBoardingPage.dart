import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/pages/Login.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Swiper(
                  layout: SwiperLayout.DEFAULT,
                  //itemWidth: MediaQuery.of(context).size.width,
                  //itemHeight: MediaQuery.of(context).size.height,
                  itemBuilder: (BuildContext context, int index) {
                    return const Text("Vanakam");
                  },
                  itemCount: 3,
                  pagination: SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            config.itemCount,
                            (index) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              width: config.activeIndex == index ? 30.0 : 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                    3), // Set your default or alternative borderRadius
                                color: config.activeIndex == index
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary // Active dot color
                                    : const Color(0xFFD9D9D9), // Inactive dot color
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  control: SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    );
                  }),
                  autoplay: true,
                  autoplayDelay: 5000,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const Text(
                "Welcome,\nUNeeds Expert!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202020),
                    fontSize: 24),
              ),
              const Text(
                "Join Our innovative service app to access a vast \ncustomer base and enjoying transparent, \nhassle-free transactions!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF808080),
                    fontSize: 13),
              ),
              Text(
                "Made in India",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
                  "Get Started",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
