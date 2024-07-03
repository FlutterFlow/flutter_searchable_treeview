import 'primitives/key_provider.dart';
import 'primitives/tree_node.dart';

/// Copies nodes to unmodifiable list, assigning missing keys and checking for duplicates.
///
/// This function takes a list of [TreeNode] objects and creates a new list with the same structure.
/// Each [TreeNode] in the new list is a copy of the corresponding [TreeNode] in the original list,
/// with the following modifications:
/// - The key of each [TreeNode] is assigned using the [KeyProvider] instance provided.
/// - The children of each [TreeNode] are recursively copied using the same process.
/// - The resulting list is made unmodifiable using the [List.unmodifiable] method.
///
/// If the input list is `null`, the function returns `null`.
///
/// Example usage:
/// ```dart
/// List<TreeNode> originalNodes = [...];
/// List<TreeNode> copiedNodes = copyTreeNodes(originalNodes);
/// ```
List<TreeNode> copyTreeNodes(List<TreeNode>? nodes) =>
    _copyNodesRecursively(nodes, KeyProvider())!;

/// Recursively copies the given list of [TreeNode] objects.
///
/// - [nodes] parameter represents the list of [TreeNode] objects to be copied.
/// - [keyProvider] parameter is a function that provides a unique key for each [TreeNode].
///
/// Returns a new list of copied [TreeNode] objects with the same properties as the original objects.
/// The children of each copied [TreeNode] are also recursively copied.
/// If the [nodes] parameter is `null`, `null` is returned.
List<TreeNode>? _copyNodesRecursively(
  List<TreeNode>? nodes,
  KeyProvider keyProvider,
) {
  if (nodes == null) {
    return null;
  }
  return List.unmodifiable(nodes.map((n) {
    return TreeNode(
      name: n.name,
      key: keyProvider.key(n.key),
      content: n.content,
      children: _copyNodesRecursively(n.children, keyProvider),
      isError: n.isError,
      isSubLevel: n.isSubLevel,
      metaData: n.metaData,
    );
  }));
}
