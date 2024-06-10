// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

import 'trees/tree_from_json.dart';

void main() {
  runApp(Demo());
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('flutter_searchable_treeview Demo'),
          ),
          body: buildBodyFrame(TreeFromJson()),
        ),
      ),
    );
  }

  /// Adds scrolling and padding to the [content].
  Widget buildBodyFrame(Widget content) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(40),
          child: content,
        ),
      ),
    );
  }
}
