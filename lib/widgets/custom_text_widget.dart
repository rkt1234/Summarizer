import 'package:flutter/widgets.dart';

class CustomTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  CustomTextWidget({super.key,required this.text, required this.style});

  @override
  State<CustomTextWidget> createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: widget.style,
    );
  }
}