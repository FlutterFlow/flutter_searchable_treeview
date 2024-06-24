import 'package:flutter/material.dart';

import 'builder.dart';
import 'node_style.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Widget that displays one [TreeNode] and its children.
class NodeWidget extends StatefulWidget {
  const NodeWidget({
    super.key,
    required this.treeNode,
    required this.state,
    required this.style,
  });

  final TreeNode treeNode;
  final TreeController state;
  final NodeStyle style;

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool get _isLeaf =>
      widget.treeNode.children == null || widget.treeNode.children!.isEmpty;

  bool get _isExpanded => widget.state.isNodeExpanded(widget.treeNode.key!);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _isExpanded ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: Material(
            color: widget.treeNode.isError
                ? style.backgroundErrorColor
                : style.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: _isLeaf
                  ? null
                  : () {
                      _isExpanded
                          ? _controller.forward()
                          : _controller.reverse();
                      setState(
                        () => widget.state.toggleNodeExpanded(
                          widget.treeNode.key!,
                          widget.treeNode.name,
                        ),
                      );
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    widget.treeNode.content,
                    if (!_isLeaf) ...[
                      const SizedBox(width: 12),
                      RotationTransition(
                        turns:
                            Tween(begin: 0.0, end: -0.25).animate(_controller),
                        child: Icon(
                          style.arrowIcon,
                          color: widget.treeNode.isSubLevel
                              ? style.arrowIconSecondaryColor
                              : style.arrowIconPrimaryColor,
                          size: style.arrowIconSize,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: style.levelIndent),
            child: buildNodes(
              widget.treeNode.children!,
              widget.state,
              widget.style,
            ),
          )
      ],
    );
  }
}
