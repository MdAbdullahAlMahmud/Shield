/**
 * Created by Abdullah on 22/8/24.
 */
import 'package:flutter/material.dart';
import 'package:shield/core/theme/color_palettes.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const ElevatedContainer({
    Key? key,
    required this.child,
    this.bgColor = ColorPalettes.colorSurface,
    this.padding,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: ColorPalettes.colorSurface,
              spreadRadius:1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        color: ColorPalettes.colorSurface,
      ),
      child: child,
    );
  }
}