import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final Color color;
  final double? height;
  final double? width;
  const AppButton(
      {super.key, required this.label,
      this.width,
      this.height,
      required this.color,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: color,
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
