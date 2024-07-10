import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextStyle style;
  final TextStyle hintStyle;
  final Icon icon;
  final TextEditingController controller;
  CustomTextField({super.key, required this.hintText, required this.style, required this.hintStyle, required this.icon, required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: widget.controller,
      style: widget.style,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        prefixIcon: widget.icon
      ),
    );
  }
}