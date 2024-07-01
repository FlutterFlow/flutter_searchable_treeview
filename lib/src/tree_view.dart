import 'package:flutter/material.dart';

import 'copy_tree_nodes.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatelessWidget {
  /// Constructs a tree view widget.
  ///
  /// - [nodes] parameter is a required list of [TreeNode] objects that represent the nodes in the tree.
  /// - [treeController] parameter is an optional [TreeController] object that controls the behavior of the tree view.
  /// - [nodeBuilder] parameter is a required function that builds a widget for each tree node.
  TreeView({
    super.key,
    required List<TreeNode> nodes,
    required this.treeController,
    required this.nodeBuilder,
    this.listPadding,
  }) : nodes = copyTreeNodes(nodes);

  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// Builder function to create a widget for each tree node.
  final Widget Function(BuildContext context, FlattenTreeNode flattenedNode)
      nodeBuilder;

  /// Tree controller to manage the tree state.
  final TreeController treeController;

  /// Padding for the list view.
  final EdgeInsets? listPadding;

  @override
  Widget build(BuildContext context) {
    final flattenedTreeNode = FlattenTreeNode.getFlattenedTree(
      nodes,
      treeController,
    );
    return ListView.builder(
      padding: listPadding ?? EdgeInsets.zero,
      itemCount: flattenedTreeNode.length,
      itemBuilder: (context, index) =>
          nodeBuilder(context, flattenedTreeNode[index]),
    );
  }
}
