import 'package:flutter/foundation.dart';

/// A controller for a tree state.
///
/// Allows to modify the state of the tree.
class TreeController {
  TreeController({
    allNodesExpanded = true,
    this.onNodeToggled,
    this.onTreeEvent,
  }) : _allNodesExpanded = allNodesExpanded;

  bool _allNodesExpanded;
  final Map<Key, bool> _expanded = <Key, bool>{};
  final Function(String name)? onNodeToggled;
  final Function(({String name, Map<String, dynamic>? params}))? onTreeEvent;

  void onEvent(({String name, Map<String, dynamic>? params}) event) =>
      onTreeEvent?.call(event);

  /// Returns whether all nodes in the tree are expanded or not.
  bool get allNodesExpanded => _allNodesExpanded;

  /// Returns whether a specific node with the given [key] is expanded or not.
  ///
  /// If the node is not found in the [_expanded] map, it returns the value of [_allNodesExpanded].
  bool isNodeExpanded(Key key) {
    return _expanded[key] ?? _allNodesExpanded;
  }

  /// Toggles the expansion state of a specific node with the given [key].
  ///
  /// If [onNodeToggled] is not null, it calls the function with the [name] of the toggled node.
  void toggleNodeExpanded(Key key, String name) {
    _expanded[key] = !isNodeExpanded(key);
    onNodeToggled?.call(name);
  }

  /// Expands all nodes in the tree.
  void expandAll() {
    _allNodesExpanded = true;
    _expanded.clear();
  }

  /// Collapses all nodes in the tree.
  void collapseAll() {
    _allNodesExpanded = false;
    _expanded.clear();
  }

  /// Expands a specific node with the given [key].
  void expandNode(Key key) {
    _expanded[key] = true;
  }

  /// Collapses a specific node with the given [key].
  void collapseNode(Key key) {
    _expanded[key] = false;
  }
}
