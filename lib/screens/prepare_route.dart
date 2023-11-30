import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nav_application/widgets/endpoints_card.dart';
import 'package:nav_application/widgets/search_listview.dart';

import '../widgets/prepare_route_fa_button.dart';

class PrepareRoute extends StatefulWidget {
  const PrepareRoute({Key? key}) : super(key: key);

  @override
  State<PrepareRoute> createState() => _PrepareRouteState();

  // Static function to reference setters from children
  static _PrepareRouteState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PrepareRouteState>();
}

class _PrepareRouteState extends State<PrepareRoute> {
  bool isLoading = false;
  bool isEmptyResponse = true;
  bool hasResponded = false;
  bool isResponseForDestination = false;

  String noRequest = 'Please enter an address or location to serach.';
  String noResponse = 'No results found for the search';

  List responses = [];
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // Define setters to be used by children widgets
  set responsesState(List responses) {
    setState(() {
      this.responses = responses;
      hasResponded = true;
      isEmptyResponse = responses.isEmpty;
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() {
        isLoading = false;
      }),
    );
  }

  set isLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  set isResponseForDestinationState(bool isResponseForDestination) {
    setState(() {
      this.isResponseForDestination = isResponseForDestination;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prepare Route'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.raleway(fontSize: 25),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            endpointsCard(sourceController, destinationController),
            isLoading
                ? const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Container(),
            isEmptyResponse
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: Text(hasResponded ? noResponse : noRequest)))
                : Container(),
            searchListView(responses, isResponseForDestination,
                destinationController, sourceController),
          ],
        ),
      )),
      floatingActionButton: viewRouteFaButton(context),
    );
  }
}
