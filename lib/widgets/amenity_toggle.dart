import 'package:flutter/material.dart';

class AmenityToggle extends StatefulWidget {
  const AmenityToggle({super.key});

  @override
  State<AmenityToggle> createState() => _AmenityToggleState();
}

List<Option> options = [
  Option('Bike Parking', const Icon(Icons.pedal_bike_rounded, size: 30), false),
  Option('Cafe', const Icon(Icons.coffee, size: 30), false),
  Option('Fast Food', const Icon(Icons.restaurant, size: 30), false),
  Option('Bar', const Icon(Icons.local_bar_rounded, size: 30), false),
];

class _AmenityToggleState extends State<AmenityToggle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option.label),
          secondary: option.icon,
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
  Icon icon;
  bool isSelected;

  Option(this.label, this.icon, this.isSelected);
}

captureSelection() async {
  List selections = [];
  for (Option option in options) {
    selections.add(option.isSelected);
  }
  return selections;
}
