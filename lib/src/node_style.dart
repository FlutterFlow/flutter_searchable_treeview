import 'package:flutter/material.dart';

class NodeStyle {
  NodeStyle({
    this.levelIndent = 16,
    this.arrowIconSize,
    this.arrowIcon = Icons.keyboard_arrow_down_rounded,
    this.arrowIconPrimaryColor = Colors.black,
    this.arrowIconSecondaryColor = Colors.white54,
    this.backgroundErrorColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
  });

  final double levelIndent;
  final double? arrowIconSize;
  final IconData arrowIcon;
  final Color arrowIconPrimaryColor;
  final Color arrowIconSecondaryColor;
  final Color backgroundErrorColor;
  final Color backgroundColor;
}
