import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/widgets/customwidgets.dart';

class JobHistoryPage extends StatefulWidget {
  const JobHistoryPage({super.key});

  @override
  State<JobHistoryPage> createState() => _JobHistoryPageState();
}

class _JobHistoryPageState extends State<JobHistoryPage> {
  Future<List<dynamic>> getTickets() {
    final data = BackendFunctions().getAllTickets();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        //title:
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 10),
          child: const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Center(
              child: Text(
                "Service History",
                style: TextStyle(
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FutureBuilder(
          future: getTickets(),
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final List<dynamic> data = snapshot.data as List<dynamic>;

                late List<dynamic> expertClosedTickets = [];
                for (var value in data) {
                  if (value["ticket_status"] == "CLOSED" &&
                      value["eid"] == SharedPrefs().expertEID) {
                    expertClosedTickets.add(value);
                  }
                }
                return Column(
                  children: List.generate(
                    expertClosedTickets.length,
                    (index) => ServiceHistoryCard(
                      TicketData: expertClosedTickets[index],
                      CardIconLoc: 'assets/images/servicehistory.png',
                      onTap: () {},
                    ),
                  ),
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
