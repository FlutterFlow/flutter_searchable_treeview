import 'primitives/tree_node.dart';

/// Copies nodes to unmodifiable list, assigning missing keys and checking for duplicates.
///
/// This function takes a list of [TreeNode] objects and a [searchFunction] that determines whether a node matches the search criteria.
/// It recursively searches through the nodes and their children, and returns a new list of nodes that match the search criteria.
/// The returned list is unmodifiable, meaning that its elements cannot be modified or removed.
///
/// If the input [nodes] is `null`, the function returns `null`.
///
/// Each node in the input list is checked against the [searchFunction]. If the node itself matches the search criteria or any of its children do,
/// a new [TreeNode] object is created with the same properties as the original node, except for the children which are replaced with the matching children.
/// If neither the node nor its children match the search criteria, `null` is returned for that node.
///
/// The returned list only contains the nodes that match the search criteria, and any `null` values are filtered out.
/// The order of the nodes in the returned list is preserved from the original list.
///
/// Example usage:
/// ```dart
/// List<TreeNode> nodes = [
///   TreeNode(key: '1', name: 'Node 1', children: [
///     TreeNode(key: '1.1', name: 'Node 1.1'),
///     TreeNode(key: '1.2', name: 'Node 1.2'),
///   ]),
///   TreeNode(key: '2', name: 'Node 2', children: [
///     TreeNode(key: '2.1', name: 'Node 2.1'),
///     TreeNode(key: '2.2', name: 'Node 2.2'),
///   ]),
/// ];
///
/// List<TreeNode> filteredNodes = searchTreeNodes(nodes, (node) => node.name.contains('1'));
/// print(filteredNodes); // Output: [TreeNode(key: '1', name: 'Node 1', children: [TreeNode(key: '1.1', name: 'Node 1.1'), TreeNode(key: '1.2', name: 'Node 1.2')])]
/// ```
List<TreeNode> searchTreeNodes(
  List<TreeNode> nodes,
  bool Function(dynamic) searchFunction,
) =>
    _searchNodesRecursively(nodes, searchFunction);

/// Recursively searches for tree nodes that match the given search function.
/// Returns a list of matching tree nodes.
///
/// - [nodes] parameter is the list of tree nodes to search.
/// - [searchFunction] parameter is a boolean function that takes a dynamic value and returns true if it matches the search criteria.
///
/// Returns a list of matching tree nodes, or null if [nodes] is null.
List<TreeNode> _searchNodesRecursively(
  List<TreeNode> nodes,
  bool Function(dynamic) searchFunction,
) {
  return nodes
      .map((node) {
        bool selfMatch =
            node.metaData != null && searchFunction(node.metaData!);
        var children = node.children != null
            ? _searchNodesRecursively(node.children!, searchFunction)
            : null;
        if (selfMatch || (children?.isNotEmpty ?? false)) {
          return TreeNode(
            key: node.key,
            name: node.name,
            content: node.content,
            children: children,
            isSubLevel: node.isSubLevel,
            isError: node.isError,
            metaData: node.metaData,
          );
        }
        return null;
      })
      .where((s) => s != null)
      .map((e) => e!)
      .toList();
}
