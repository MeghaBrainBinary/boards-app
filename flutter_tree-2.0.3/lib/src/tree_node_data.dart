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
  String icon;
  bool checked;
  bool isTop;
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
    required this.isTop,

    this.title = '',
    this.icon = '',
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
        icon: other.icon,
        extra: other.extra,
        isTop: other.isTop,
        checked: other.checked,
        checkBoxCheckColor: other.checkBoxCheckColor,
        checkBoxFillColor: other.checkBoxFillColor,
        backgroundColor: other.backgroundColor,
        customActions: other.customActions,

      );

  @override
  String toString() {
    return 'TreeNodeData{id: $id, expanded: $expanded, name: $name, language: $language, parent_id: $parent_id, sub_parent_id: $sub_parent_id, children: $children, title: $title, icon: $icon, checked: $checked, isTop: $isTop, extra: $extra, checkBoxCheckColor: $checkBoxCheckColor, checkBoxFillColor: $checkBoxFillColor, backgroundColor: $backgroundColor, customActions: $customActions}';
  }
}