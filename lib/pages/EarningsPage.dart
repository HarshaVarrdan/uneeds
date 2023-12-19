import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  String earnings = "Rs. " + "1722";
  late int showingTooltip;

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            borderRadius: BorderRadius.circular(7),
            width: 30,
            color: showingTooltip != x
                ? const Color(0xFF937AFF)
                : Theme.of(context).colorScheme.secondary),
      ],
    );
  }

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFDEDEDE),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Wallet Balance",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF808080)),
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF202020),
                                ),
                                children: [
                                  TextSpan(text: "Rs. "),
                                  TextSpan(text: "1820"),
                                ],
                              ),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.secondary,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "Withdraw",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "DMSans",
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [const Text("Date 8 - 14"), Text(earnings)],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: BarChart(
                              BarChartData(
                                barGroups: [
                                  generateGroupData(0, 30),
                                  generateGroupData(1, 50),
                                  generateGroupData(2, 24),
                                  generateGroupData(3, 10),
                                  generateGroupData(4, 16),
                                  generateGroupData(5, 36),
                                  generateGroupData(6, 28),
                                ],
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  handleBuiltInTouches: false,
                                  touchCallback: (event, response) {
                                    if (response != null &&
                                        response.spot != null &&
                                        event is FlTapUpEvent) {
                                      setState(() {
                                        final x =
                                            response.spot!.touchedBarGroup.x;
                                        final isShowing = showingTooltip == x;
                                        if (isShowing) {
                                          showingTooltip = -1;
                                        } else {
                                          showingTooltip = x;
                                        }
                                      });
                                    }
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: bottomTitles,
                                      reservedSize: 42,
                                    ),
                                  ),
                                  leftTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(show: false),
                                gridData: const FlGridData(show: false),
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("Total Services"), Text("32")],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text("Total Online"), Text("89h 32m")],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Earnings"), Text("Rs. 8231")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Your Earnings"), Text("Rs. 7677")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Taxes"), Text("Rs. 823")],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
