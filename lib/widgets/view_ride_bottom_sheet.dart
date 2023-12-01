import 'package:flutter/material.dart';

import '../helpers/shared_prefs.dart';
import '../screens/navigation.dart';

Widget viewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime) {
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destinationAddress = getSourceAndDestinationPlaceText('destination');

  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$sourceAddress ➡ $destinationAddress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.indigo)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('$distance mi ► $dropOffTime min'),
                    trailing: const Text('Stress Level: 1',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Navigation())),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Route',
                            style: TextStyle(fontSize: 20),
                          ),
                        ])),
              ]),
        ),
      ),
    ),
  );
}