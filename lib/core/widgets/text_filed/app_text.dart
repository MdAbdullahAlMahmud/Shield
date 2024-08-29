/**
 * Created by Abdullah on 25/8/24.
 */

import 'package:flutter/material.dart';
import 'package:shield/core/theme/color_palettes.dart';

class AppText extends Text {
  AppText(text)
      : super(
          text,
          style: TextStyle(
            color: ColorPalettes.textColorOnLightTheme,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        );
}
