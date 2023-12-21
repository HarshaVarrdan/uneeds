import 'package:flutter/material.dart';
import 'package:uneeds/extra/BackendFunctions.dart';
import 'package:uneeds/extra/SaveUserPreference.dart';
import 'package:uneeds/widgets/CustomWidgets.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key, required this.Discover});

  final bool Discover;

  @override
  State<TicketsPage> createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> getTickets() {
    final data = BackendFunctions().getAllTickets(context);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

              late List<dynamic> acceptedTickets = [];
              for (var value in data) {
                if (value["ticket_status"] == "ASSIGNED" &&
                    value["eid"] == SharedPrefs().expertEID) {
                  acceptedTickets.add(value);
                }
              }

              late List<dynamic> openTickets = [];
              for (var value in data) {
                if (value["ticket_status"] == "OPEN") {
                  openTickets.add(value);
                }
              }
              print(widget.Discover);
              return Column(
                children: List.generate(
                  widget.Discover ? openTickets.length : acceptedTickets.length,
                  (index) => OpenTicketCard(
                    TicketData: widget.Discover
                        ? openTickets[index]
                        : acceptedTickets[index],
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
    );
  }
}
