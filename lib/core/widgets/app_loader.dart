/**
 * Created by Abdullah on 22/8/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/theme/color_palettes.dart';
import 'elevated_container.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ElevatedContainer(
          bgColor: Colors.transparent,
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(
          color:  ColorPalettes.colorPrimary,
        ),
      ),
    );
  }
}