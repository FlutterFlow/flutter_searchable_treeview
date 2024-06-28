import 'package:flutter/material.dart';

import 'copy_tree_nodes.dart';
import 'node_style.dart';
import 'node_widget.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatelessWidget {
  /// Constructs a tree view widget.
  ///
  /// - [nodes] parameter is a required list of [TreeNode] objects that represent the nodes in the tree.
  /// - [treeController] parameter is an optional [TreeController] object that controls the behavior of the tree view.
  /// - [style] parameter is an optional [TreeViewStyle] object that defines the style of the tree view.
  TreeView({
    super.key,
    required List<TreeNode> nodes,
    required this.treeController,
    this.style,
  }) : nodes = copyTreeNodes(nodes);

  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// The style to be applied to the tree view.
  final NodeStyle? style;

  /// Tree controller to manage the tree state.
  final TreeController treeController;

  @override
  Widget build(BuildContext context) {
    final nodeStyle = style ?? NodeStyle(arrowIconSize: 16, levelIndent: 16);
    final flattenedTree = FlattenTreeNode.getFlattenedTree(
      nodes,
      treeController,
    );
    return ListView.builder(
      itemCount: flattenedTree.length,
      itemBuilder: (context, index) => NodeWidget(
        key: flattenedTree[index].key,
        treeNode: flattenedTree[index].node,
        state: treeController,
        level: flattenedTree[index].level,
        style: nodeStyle,
      ),
    );
  }
}
