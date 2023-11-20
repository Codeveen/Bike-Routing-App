import 'package:flutter/material.dart';

class TopologyToggle extends StatefulWidget {
  const TopologyToggle({super.key});

  @override
  State<TopologyToggle> createState() => _TopologyToggleState();
}

class _TopologyToggleState extends State<TopologyToggle> {
  List<Option> options = [
    Option('Neighborhood Streets', true),
    Option('Connector Streets', true),
    Option('Sub-Urban Streets', true),
    Option('Main Streets', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option.label),
          value: option.isSelected,
          onChanged: (bool? value) {
            setState(() {
              option.isSelected = value!;
            });
          },
        );
      }).toList(),
    );
  }
}

class Option {
  final String label;
  bool isSelected;

  Option(this.label, this.isSelected);
}

captureSelection() async {
  // Capture current boolean for each option in order to store
}
