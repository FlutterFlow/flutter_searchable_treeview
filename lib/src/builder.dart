import 'package:flutter/material.dart';
import 'node_style.dart';
import 'node_widget.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Builds set of [nodes] respecting [state], [indent] and [iconSize].
Widget buildNodes(
  Iterable<TreeNode> nodes,
  TreeController state,
  NodeStyle style,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final node in nodes)
        NodeWidget(
          key: ValueKey(node.key),
          treeNode: node,
          state: state,
          style: style,
        )
    ],
  );
}
