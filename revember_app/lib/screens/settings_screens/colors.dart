import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({Key? key}) : super(key: key);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  // Define a list of colors to choose from
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];

  // Define a variable to hold the currently selected color
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the selected color
        Container(
          width: 50,
          height: 50,
          color: selectedColor,
        ),
        // Create a button for each color in the list
        for (var color in colors)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: CircleBorder(),
            ),
            onPressed: () {
              // Update the selected color when a button is pressed
              setState(() {
                selectedColor = color;
              });
            },
            child: SizedBox(
              width: 30,
              height: 30,
            ),
          ),
      ],
    );
  }
}
