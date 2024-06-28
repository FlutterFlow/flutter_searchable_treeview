import 'package:flutter/material.dart';

/// Represents the style properties for a node in a tree view.
class NodeStyle {
  /// Creates a new instance of [NodeStyle].
  ///
  /// - [levelIndent] specifies the indentation for each level of the tree.
  /// - [arrowIconSize] specifies the size of the arrow icon.
  /// - [arrowIcon] specifies the icon to be used for the arrow.
  /// - [arrowIconPrimaryColor] specifies the primary color of the arrow icon.
  /// - [arrowIconSecondaryColor] specifies the secondary color of the arrow icon.
  /// - [backgroundErrorColor] specifies the background color for error states.
  /// - [backgroundColor] specifies the background color for normal states.
  NodeStyle({
    this.levelIndent = 16,
    this.arrowIconSize,
    this.arrowIcon = Icons.keyboard_arrow_down_rounded,
    this.arrowIconPrimaryColor = Colors.black,
    this.arrowIconSecondaryColor = Colors.white54,
    this.backgroundErrorColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
  });

  /// Specifies the indentation for each level of the tree.
  final double levelIndent;

  /// Specifies the size of the arrow icon.
  final double? arrowIconSize;

  /// Specifies the icon to be used for the arrow.
  final IconData arrowIcon;

  /// Specifies the primary color of the arrow icon.
  final Color arrowIconPrimaryColor;

  /// Specifies the secondary color of the arrow icon.
  final Color arrowIconSecondaryColor;

  /// Specifies the background color for error state.
  final Color backgroundErrorColor;

  /// Specifies the background color.
  final Color backgroundColor;
}
