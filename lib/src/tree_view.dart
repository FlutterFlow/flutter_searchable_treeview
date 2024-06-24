import 'package:flutter/material.dart';

import 'builder.dart';
import 'copy_tree_nodes.dart';
import 'node_style.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatefulWidget {
  /// Constructs a tree view widget.
  ///
  /// - [nodes] parameter is a required list of [TreeNode] objects that represent the nodes in the tree.
  /// - [treeController] parameter is an optional [TreeController] object that controls the behavior of the tree view.
  /// - [style] parameter is an optional [TreeViewStyle] object that defines the style of the tree view.
  TreeView({
    super.key,
    required List<TreeNode> nodes,
    this.treeController,
    this.style,
  }) : nodes = copyTreeNodes(nodes);

  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// The style to be applied to the tree view.
  final NodeStyle? style;

  /// Tree controller to manage the tree state.
  final TreeController? treeController;

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late final TreeController _controller;
  late final NodeStyle _style;

  @override
  void initState() {
    _controller = widget.treeController ?? TreeController();
    _style = widget.style ??
        NodeStyle(
          arrowIconSize: 16,
          levelIndent: 16,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes(
      widget.nodes,
      _controller,
      _style,
    );
  }
}
