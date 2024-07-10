import 'package:flutter/widgets.dart';

class CustomContainerWidget extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color color;
  final Widget child;
  final EdgeInsets padding;
  const CustomContainerWidget({super.key, required this.height, required this.width, required this.color, required this.child, required this.borderRadius, required this.padding});

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: widget.child,
    );
  }
}