import 'dart:ffi';

import 'package:flutter/material.dart';

import '../widgets/amenity_toggle.dart';
import '../widgets/topology_toggle.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int selectedIndex = 0;

  Map<Bool, dynamic> selection = {};

  @override
  Widget build(BuildContext context) {
    // Bottom Bar with Topologies and Amenities
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        // Topology item
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_road_rounded),
          label: 'Stress Level',
        ),
        // Amenity item
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted_rounded),
          label: 'Amenities',
        ),
      ],
      // Item specifics
      backgroundColor: Colors.blue[400],
      iconSize: 35,
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      // On item tap, check index and display dialog box for that index
      onTap: (int index) {
        switch (index) {
          // Topology
          case 0:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Street Topologies"),
                  content: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TopologyToggle()),
                  actions: [
                    ElevatedButton(
                      child: const Text("Done"),
                      onPressed: () {
                        // Add captureSelection
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
            break;
          // Amenity
          case 1:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Amenities"),
                  content: const Padding(
                    padding: EdgeInsets.all(0),
                    child: AmenityToggle(),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text("Done"),
                      onPressed: () {
                        // Add captureSelection
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
            break;
        }
        setState(
          () {
            selectedIndex = index;
          },
        );
      },
    );
  }
}

class Option {
  final String label;
  bool isSelected;

  Option(this.label, this.isSelected);
}
