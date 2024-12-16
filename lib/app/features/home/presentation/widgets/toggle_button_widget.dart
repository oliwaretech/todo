import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomToggleButton extends StatefulWidget {
  final bool darkMode;
  final TargetPlatform platform;
  final Function onChanged;
  const CustomToggleButton({super.key,
    required this.darkMode,
    required this.onChanged,
    required this.platform,});

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    return widget.platform == TargetPlatform.iOS ? CupertinoSwitch(
        value: widget.darkMode,
        onChanged: (val){
          widget.onChanged(val);
        }) : Switch(
        value: widget.darkMode,
        onChanged: (val){
          widget.onChanged(val);
        }
    );
  }
}
