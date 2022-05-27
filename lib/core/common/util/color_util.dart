import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/core/common/util/theme_util.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';

Color getNoteColor(BuildContext context, int colorIndex) {
  final isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark();
  final noteColor = ColorManager.noteColors.elementAt(colorIndex);
  return isDark ? noteColor.darkColor : noteColor.lightColor;
}
