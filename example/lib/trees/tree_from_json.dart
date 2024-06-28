// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterflow_tree_view/flutterflow_tree_view.dart';

/// Demonstrates how to convert a json content to tree, allowing user to
/// modify the content and see how it affects the tree.
class TreeFromJson extends StatefulWidget {
  @override
  _TreeFromJsonState createState() => _TreeFromJsonState();
}

class _TreeFromJsonState extends State<TreeFromJson> {
  final TreeController _treeController =
      TreeController(allNodesExpanded: false);
  final TextEditingController _textController = TextEditingController(text: '''
{
  "employee": {
    "name": "sonoo",
    "level": 56,
    "married": true,
    "hobby": null
  },
  "week": [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ]
}
''');

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            height: 600,
            width: 400,
            child: TextField(
              maxLines: 10000,
              controller: _textController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              style: TextStyle(fontFamily: "courier"),
            )),
        IconButton(
          icon: Icon(Icons.arrow_right),
          iconSize: 40,
          onPressed: () => setState(() {}),
        ),
        Expanded(child: buildTree()),
      ],
    );
  }

  /// Builds tree or error message out of the entered content.
  Widget buildTree() {
    try {
      var parsedJson = json.decode(_textController.text);
      return TreeView(
        treeController: _treeController,
        nodes: toTreeNodes(parsedJson),
      );
    } on FormatException catch (e) {
      return Text(e.message);
    }
  }

  List<TreeNode> toTreeNodes(dynamic parsedJson) {
    if (parsedJson is Map<String, dynamic>) {
      return parsedJson.keys
          .map((k) => TreeNode(
                name: k,
                content: Text('$k:'),
                children: toTreeNodes(parsedJson[k]),
              ))
          .toList();
    }
    if (parsedJson is List<dynamic>) {
      return parsedJson
          .asMap()
          .map((i, element) => MapEntry(
              i,
              TreeNode(
                name: i.toString(),
                content: Text('[$i]:'),
                children: toTreeNodes(element),
              )))
          .values
          .toList();
    }
    return [
      TreeNode(
        name: 'JSON',
        content: Text(parsedJson.toString()),
      )
    ];
  }
}
