import 'package:flutter/material.dart';

class TreeNodeData {
  int id;
  bool expanded;
  String name;
  String language;
  String parent_id;
  String quote;
  String name_text_color;
  String name_font_family;
  String quote_text_color;
  String quote_font_family;
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
    required this.quote,
    required this.name_text_color,
    required this.name_font_family,
    required this.quote_text_color,
    required this.quote_font_family,
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
        quote: other.quote ?? '',
        name_text_color: other.name_text_color ?? '',
        name_font_family: other.name_font_family ?? '',
        quote_text_color: other.quote_text_color ?? '',
        quote_font_family: other.quote_font_family ?? '',
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
    return 'TreeNodeData{id: $id, expanded: $expanded, name: $name, language: $language, parent_id: $parent_id, sub_parent_id: $sub_parent_id, quote: $quote, quote_text_color $quote_text_color, quote_font_family $quote_font_family name_text_color: $name_text_color, name_font_family: $name_font_family,children: $children, title: $title, icon: $icon, checked: $checked, isTop: $isTop, extra: $extra, checkBoxCheckColor: $checkBoxCheckColor, checkBoxFillColor: $checkBoxFillColor, backgroundColor: $backgroundColor, customActions: $customActions}';
  }
}