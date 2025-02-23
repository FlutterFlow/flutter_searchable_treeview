import 'package:flutter/material.dart';
import '../primitives/tree_controller.dart';

/// Represents a tree node.
class TreeNode {
  /// Constructs a tree node.
  ///
  /// - [name] parameter is required and represents the name of the node.
  /// - [children] parameter is an optional list of child nodes.
  /// - [content] parameter is an optional widget to be displayed as the content of the node.
  /// - [key] parameter is an optional key for the node.
  /// - [metaData] parameter is an optional dynamic metadata associated with the node.
  /// - [isError] parameter is a boolean indicating whether the node represents an error.
  /// - [isSubLevel] parameter is a boolean indicating whether the node is a sub-level node.
  const TreeNode({
    this.key,
    required this.name,
    this.children,
    Widget? content,
    this.metaData,
    this.isError = false,
    this.isSubLevel = false,
  }) : content = content ?? const SizedBox();

  /// The name of the tree node.
  final String name;

  /// The children of the tree node.
  final List<TreeNode>? children;

  /// The content widget associated with the tree node.
  final Widget content;

  /// The key of the tree node.
  final Key? key;

  /// The metadata associated with the tree node.
  final dynamic metaData;

  /// Indicates whether the tree node represents an error.
  final bool isError;

  /// Indicates whether the tree node is a sub-level node.
  final bool isSubLevel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is TreeNode &&
        other.name == name &&
        other.isError == isError &&
        other.isSubLevel == isSubLevel &&
        _listEquals(other.children, children) &&
        other.metaData == metaData;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      isError,
      isSubLevel,
      children == null ? null : Object.hashAll(children!), // Hash child nodes
      metaData,
    );
  }

  /// Helper method to compare two lists of TreeNode objects
  static bool _listEquals(List<TreeNode>? a, List<TreeNode>? b) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Represents a flattened tree node.
class FlattenTreeNode {
  /// Constructs a flattened tree node.
  ///
  /// - [node] parameter represents the original tree node.
  /// - [key] parameter is an optional key for the node.
  /// - [level] parameter represents the level of the node in the tree.
  /// - [isVisible] parameter is a boolean indicating whether the node is visible.
  const FlattenTreeNode({
    required this.node,
    this.key,
    this.level = 0,
    this.isVisible = true,
  });

  /// An optional key for the node.
  final Key? key;

  /// The original tree node.
  final TreeNode node;

  /// The level of the node in the tree.
  final int level;

  /// Indicates whether the node is visible.
  final bool isVisible;

  /// Returns a flattened tree from the given list of top-level nodes.
  ///
  /// - [topLevelNodes] parameter is a list of top-level [TreeNode]s.
  /// - [controller] parameter is a [TreeController] used to determine node expansion.
  static List<FlattenTreeNode> getFlattenedTree(
    List<TreeNode> topLevelNodes,
    TreeController controller,
  ) {
    List<FlattenTreeNode> result = [];
    for (TreeNode node in topLevelNodes) {
      _flattenTree(node, 0, true, result, controller);
    }
    return result;
  }

  /// Flattens the tree structure of [node] and its children into a list of [FlattenTreeNode].
  ///
  /// - [level] parameter represents the depth level of the current [node] in the tree.
  /// - [isVisible] parameter indicates whether the [node] should be visible or hidden.
  /// - [result] parameter is the list where the flattened tree nodes will be added.
  /// - [controller] parameter is used to check if a node is expanded or collapsed.
  static void _flattenTree(
    TreeNode node,
    int level,
    bool isVisible,
    List<FlattenTreeNode> result,
    TreeController controller,
  ) {
    bool nodeExpanded = controller.isNodeExpanded(node.key!);
    result.add(FlattenTreeNode(
        key: node.key, node: node, level: level, isVisible: isVisible));

    if (node.children != null && nodeExpanded) {
      for (TreeNode child in node.children!) {
        _flattenTree(child, level + 1, isVisible, result, controller);
      }
    }
  }
}
