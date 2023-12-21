import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String svgIconPath;
  final Color buttonColor;

  const CustomFloatingButton({
    required this.onPressed,
    required this.svgIconPath,
    required this.buttonColor,
    super.key,
  });

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      backgroundColor: widget.buttonColor,
      shape: const CircleBorder(),
      child: SvgPicture.asset(widget.svgIconPath, width: 65, height: 65),
    );
  }
}
