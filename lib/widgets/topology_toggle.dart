import 'package:flutter/material.dart';

class TopologyToggle extends StatefulWidget {
  const TopologyToggle({super.key});

  @override
  State<TopologyToggle> createState() => _TopologyToggleState();
}

List<Option> options = [
  Option('Neighborhood Streets', true),
  Option('Connector Streets', true),
  Option('Sub-Urban Streets', true),
  Option('Main Streets', true),
];

captureSelection(List<Option> options) async {
  List selections = [];
  for (Option option in options) {
    selections.add(option.isSelected);
  }
  return selections;
}

class _TopologyToggleState extends State<TopologyToggle> {
  List tSelections = [true, true, true, true];
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
              tSelections = captureSelection(options);
              Navigator.pop(context, [tSelections]);
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
