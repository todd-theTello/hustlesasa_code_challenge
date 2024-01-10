import 'package:flutter/material.dart';

///
class CircleContainer extends StatelessWidget {
  ///
  const CircleContainer({super.key, this.color, this.child, this.padding, this.border, this.width, this.height});

  ///
  final double? height;

  ///
  final double? width;

  ///
  final Color? color;

  ///
  final Widget? child;

  ///
  final EdgeInsetsGeometry? padding;

  ///
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: border,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
