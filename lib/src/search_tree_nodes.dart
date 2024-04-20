// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'primitives/tree_node.dart';

/// Copies nodes to unmodifiable list, assigning missing keys and checking for duplicates.
List<TreeNode> searchTreeNodes(
    List<TreeNode>? nodes, bool Function(Map<String, dynamic>) searchFunction) {
  return _searchNodesRecursively(nodes, searchFunction)!;
}

List<TreeNode>? _searchNodesRecursively(
    List<TreeNode>? nodes, bool Function(Map<String, dynamic>) searchFunction) {
  if (nodes == null) {
    return null;
  }
  return nodes
      .map((node) {
        bool selfMatch =
            node.metaData != null ? searchFunction(node.metaData!) : false;
        var children = _searchNodesRecursively(node.children, searchFunction);
        if (selfMatch || (children?.isNotEmpty ?? false)) {
          return TreeNode(
            key: node.key,
            content: node.content,
            children: children,
          );
        }
        return null;
      })
      .where((s) => s != null)
      .map((e) => e!)
      .toList();
}
