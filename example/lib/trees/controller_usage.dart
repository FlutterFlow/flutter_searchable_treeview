// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:flutter_searchable_treeview/flutter_searchable_treeview.dart';

/// Demonstrates how to change state of the tree in external event handlers,
/// like button taps.
class ControllerUsage extends StatefulWidget {
  @override
  _ControllerUsageState createState() => _ControllerUsageState();
}

class _ControllerUsageState extends State<ControllerUsage> {
  final Key _key = ValueKey(22);
  final ExpandableTreeController _controller =
      ExpandableTreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 300,
          width: 300,
          child: buildTree(),
        ),
        ElevatedButton(
          child: Text("Expand All"),
          onPressed: () => setState(() {
            _controller.expandAll();
          }),
        ),
        ElevatedButton(
          child: Text("Collapse All"),
          onPressed: () => setState(() {
            _controller.collapseAll();
          }),
        ),
        ElevatedButton(
          child: Text("Expand node 22"),
          onPressed: () => setState(() {
            _controller.expandNode(_key);
          }),
        ),
        ElevatedButton(
          child: Text("Collapse node 22"),
          onPressed: () => setState(() {
            _controller.collapseNode(_key);
          }),
        ),
      ],
    );
  }

  Widget buildTree() {
    final nodeBuilder = (node) {
      return ExpandableNodeWidget(
        treeNode: node,
        state: _controller,
        indent: 10,
        iconSize: 24,
      );
    };
    return TreeView(
      nodes: [
        TreeNode(
          content: Text("node 1"),
          nodeBuilder: nodeBuilder,
        ),
        TreeNode(
          content: Icon(Icons.audiotrack),
          children: [
            TreeNode(
              content: Text("node 21"),
              nodeBuilder: nodeBuilder,
            ),
            TreeNode(
              content: Text("node 22"),
              key: _key,
              children: [
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                  nodeBuilder: nodeBuilder,
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_dissatisfied),
                  nodeBuilder: nodeBuilder,
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_neutral),
                  nodeBuilder: nodeBuilder,
                ),
              ],
              nodeBuilder: (node) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    node.content,
                    if (node.children != null)
                      ...node.children!.map((e) => e.nodeBuilder(e)).toList()
                  ],
                );
              },
            ),
            TreeNode(
              content: Text("node 23"),
              nodeBuilder: nodeBuilder,
            ),
          ],
          nodeBuilder: nodeBuilder,
        ),
      ],
    );
  }
}
