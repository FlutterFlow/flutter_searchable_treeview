// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

typedef NodeBuilder = Widget Function(TreeNode);

/// One node of a tree.
class TreeNode {
  final List<TreeNode>? children;
  final Widget content;
  final Key? key;
  final dynamic metaData;
  final NodeBuilder nodeBuilder;

  TreeNode({
    this.key,
    this.children,
    Widget? content,
    this.metaData,
    required this.nodeBuilder,
  }) : content = content ?? Container(width: 0, height: 0);
}
