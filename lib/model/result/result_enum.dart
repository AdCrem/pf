import 'dart:ui';

import 'package:flutter/material.dart';

import '../../ui/resources/app_colors/app_colors.dart';

enum ResultTile { start, end, path, blocked, empty }

extension ColorExtension on ResultTile {
  Color get color {
    switch (this) {
      case ResultTile.start:
        return AppColors.lightBlue;
      case ResultTile.end:
        return AppColors.darkBlue;
      case ResultTile.path:
        return AppColors.path;
      case ResultTile.blocked:
        return AppColors.blocked;
      case ResultTile.empty:
        return AppColors.white;
      default:
        return Colors.transparent;
    }
  }
}
