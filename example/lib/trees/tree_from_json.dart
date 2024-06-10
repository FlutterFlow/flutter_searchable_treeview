// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_searchable_treeview/flutter_searchable_treeview.dart';
import 'package:text_search/text_search.dart';

extension ListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

/// Demonstrates how to convert a json content to tree, allowing user to
/// modify the content and see how it affects the tree.
class TreeFromJson extends StatefulWidget {
  @override
  _TreeFromJsonState createState() => _TreeFromJsonState();
}

class _TreeFromJsonState extends State<TreeFromJson> {
  final ExpandableTreeController _treeController =
      ExpandableTreeController(allNodesExpanded: true);
  TextEditingController searchController = TextEditingController();
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
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 50,
              width: 400,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: "courier"),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
                height: 600,
                width: 400,
                child: TextField(
                  maxLines: 10000,
                  controller: _textController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  style: TextStyle(fontFamily: "courier"),
                )),
          ],
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          iconSize: 40,
          onPressed: () => setState(() {}),
        ),
        buildTree(),
      ],
    );
  }

  /// Builds tree or error message out of the entered content.
  Widget buildTree() {
    try {
      var parsedJson = json.decode(_textController.text);
      return TreeView(
        nodes: searchTreeNodes(toTreeNodes(parsedJson), (data) {
          final searchTerm = searchController.text;
          if (searchTerm.isEmpty) {
            return true;
          }
          final textSearch = TextSearch(
            [
              TextSearchItem.fromTerms(
                  data, [data['name']].where((e) => e != null).map((e) => e!))
            ],
          );
          return textSearch.search(searchTerm, matchThreshold: 1).isNotEmpty;
        }),
      );
    } on FormatException catch (e) {
      return Text(e.message);
    }
  }

  List<TreeNode> toTreeNodes(dynamic parsedJson) {
    final nodeBuilder = (node) {
      return ExpandableNodeWidget(
        treeNode: node,
        state: _treeController,
        indent: 10,
        iconSize: 24,
      );
    };
    if (parsedJson is Map<String, dynamic>) {
      return parsedJson.keys
          .map((k) => TreeNode(
                content: Text('$k:'),
                children: toTreeNodes(parsedJson[k]),
                nodeBuilder: (node) {
                  if (node.children.isNullOrEmpty) {
                    return SizedBox();
                  }
                  if (node.children!.length == 1 &&
                      node.children!.first.children.isNullOrEmpty) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        node.content,
                        SizedBox(width: 10),
                        node.children!.first.nodeBuilder(node.children!.first),
                      ],
                    );
                  } else {
                    return nodeBuilder(node);
                  }
                },
              ))
          .toList();
    }
    if (parsedJson is List<dynamic>) {
      return [
        TreeNode(
          children: parsedJson
              .map((e) => TreeNode(
                    children: toTreeNodes(e),
                    nodeBuilder: (node) {
                      if (node.children.isNullOrEmpty) {
                        return SizedBox();
                      }
                      if (node.children!.length == 1 &&
                          node.children!.first.children.isNullOrEmpty) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            node.children!.first
                                .nodeBuilder(node.children!.first),
                            Text(', '),
                          ],
                        );
                      } else {
                        return nodeBuilder(node);
                      }
                    },
                    metaData: {'name': e.toString()},
                  ))
              .toList(),
          nodeBuilder: (node) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('['),
                if (node.children != null)
                  ...node.children!.map((e) => e.nodeBuilder(e)).toList(),
                Text(']'),
              ],
            );
          },
        )
      ];
    }
    return [
      TreeNode(
          content: Text(parsedJson.toString()),
          nodeBuilder: (node) => node.content,
          metaData: {'name': parsedJson.toString()})
    ];
  }
}
