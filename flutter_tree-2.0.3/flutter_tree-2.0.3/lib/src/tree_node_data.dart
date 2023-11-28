import 'package:flutter/material.dart';

class TreeNodeData {
  int id;
  bool expanded;
  String name;
  String language;
  String parent_id;
  String sub_parent_id;
  List<TreeNodeData> children;
  String title;
  bool checked;
  dynamic extra;
  final Color? checkBoxCheckColor;
  final MaterialStateProperty<Color>? checkBoxFillColor;
  final ValueGetter<Color>? backgroundColor;
  final List<Widget>? customActions;

  TreeNodeData({
    required this.id,
    this.expanded = false,
    required this.children,
    required this.sub_parent_id,
    required this.parent_id,
    required this.language,
    required this.name,

    this.title = '',
    this.extra,
    this.checked = false,

    this.checkBoxCheckColor,
    this.checkBoxFillColor,
    this.backgroundColor,
    this.customActions,

  }


      );

  TreeNodeData.from(TreeNodeData other):
        this(
        id: other.id,
        name: other.name,
        expanded: other.expanded,
        language: other.language,
        parent_id: other.parent_id,
        sub_parent_id: other.sub_parent_id,
        children: other.children.map((e) => TreeNodeData.from(e)).toList(),
        title: other.title,
        extra: other.extra,
        checked: other.checked,
        checkBoxCheckColor: other.checkBoxCheckColor,
        checkBoxFillColor: other.checkBoxFillColor,
        backgroundColor: other.backgroundColor,
        customActions: other.customActions,

      );

  @override
  String toString() {
    return 'TreeNodeData{title: $title, extra: $extra, checked: $checked, expanded: $expanded, children: $children}';
  }
}