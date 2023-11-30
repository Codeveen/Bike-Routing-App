import 'package:flutter/material.dart';

class AmenityToggle extends StatefulWidget {
  const AmenityToggle({super.key});

  @override
  State<AmenityToggle> createState() => _AmenityToggleState();
}

List<Option> options = [
  Option(
      'Resturants',
      Image.asset(
        "assets/icon/burger.png",
        height: 30,
        width: 30,
      ),
      false),
  Option(
      'Restrooms',
      Image.asset(
        "assets/icon/restroom.png",
        height: 30,
        width: 30,
      ),
      false),
  Option(
      'Bike Repair',
      Image.asset(
        "assets/icon/bike-repair.png",
        height: 30,
        width: 30,
      ),
      false),
  Option(
      'Bike Racks',
      Image.asset(
        "assets/icon/bike-parking.png",
        height: 30,
        width: 30,
      ),
      false),
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
  Image icon;
  bool isSelected;

  Option(this.label, this.icon, this.isSelected);
}

captureSelection() async {
  // Capture current boolean for each option in order to store
}
