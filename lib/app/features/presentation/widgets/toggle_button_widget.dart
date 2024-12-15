import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomToggleButton extends StatefulWidget {
  final bool darkMode;
  final Function onChanged;
  const CustomToggleButton({super.key,
    required this.darkMode,
    required this.onChanged});

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        value: widget.darkMode,
        onChanged: (val){
          widget.onChanged(val);
        });
  }
}
