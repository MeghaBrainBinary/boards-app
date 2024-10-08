import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';

import './tree_node.dart';
import './tree_node_data.dart';

class TreeView extends StatefulWidget {
  final List<TreeNodeData> data;
  final String selectedId;
  final bool view;
  final bool lazy;
  final TextStyle? textStyle;
  final Widget icon;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double offsetLeft;
  final bool showFilter;
  final bool showActions;
  final bool showCheckBox;

  final Function(TreeNodeData parent,TreeNodeData node)? onTap;
  final Function(TreeNodeData parent,TreeNodeData node)? onLastTap;
  final void Function(TreeNodeData node)? onLoad;
  final void Function(TreeNodeData node)? onExpand;
  final void Function(TreeNodeData node)? onCollapse;
  final void Function(bool checked, TreeNodeData node)? onCheck;
  final void Function(TreeNodeData node, TreeNodeData parent)? onAppend;
  final void Function(TreeNodeData node, TreeNodeData parent)? onRemove;

  final TreeNodeData Function(TreeNodeData parent)? append;
  final Future<List<TreeNodeData>> Function(TreeNodeData parent)? load;

  const TreeView({
    Key? key,
    required this.data,
    this.textStyle,
    this.onTap,
    this.onLastTap,
    this.leftIcon,
    this.rightIcon,
    this.onCheck,
    this.onLoad,
    this.onExpand,
    this.onCollapse,
    this.onAppend,
    this.onRemove,
    this.append,
    this.load,
    this.lazy = false,
    this.offsetLeft = 24.0,
    this.showFilter = false,
    this.showActions = false,
    this.showCheckBox = false,
    this.icon = const Icon(Icons.expand_more, size: 16.0),
    required this.view,
    required this.selectedId,
  }) : super(key: key);

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late TreeNodeData _root;
  List<TreeNodeData> _renderList = [];

  List<TreeNodeData> _filter(String val, List<TreeNodeData> list) {
    List<TreeNodeData> temp = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].title.contains(val)) {
        temp.add(list[i]);
      }
      if (list[i].children.isNotEmpty) {
        list[i].children = _filter(val, list[i].children);
      }
    }
    return temp;
  }

  void _onChange(String val) {
    if (val.isNotEmpty) {
      _renderList = _filter(val, _renderList);
    } else {
      _renderList = widget.data;
    }
    setState(() {});
  }

  void append(TreeNodeData parent) {
    parent.children.add(widget.append!(parent));
    setState(() {});
  }

  void _remove(TreeNodeData node, List<TreeNodeData> list) {
    for (int i = 0; i < list.length; i++) {
      if (node == list[i]) {
        list.removeAt(i);
      } else {
        _remove(node, list[i].children);
      }
    }
  }

  void remove(TreeNodeData node) {
    _remove(node, _renderList);
    setState(() {});
  }

  Future<bool> load(TreeNodeData node) async {
    try {
      final data = await widget.load!(node);
      node.children = data;
      setState(() {});
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _renderList = widget.data;
    _root = TreeNodeData(
      name: "",
       language: "",
      id: 0,
      sub_parent_id: "0",
      parent_id: "0",
      title: '',
      quote: '',
      quote_font_family: '',
      quote_text_color: '',
      name_text_color: '',
      name_font_family: '',
      isTop: false,
      extra: null,
      checked: false,
      expanded: false,
      children: _renderList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.showFilter)
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                bottom: 12.0,
              ),
              child: TextField(onChanged: _onChange),
            ),
          ...List.generate(
            _renderList.length,
                (int index) {
              return TreeNode(
                selectedId: widget.selectedId,
                load: load,
                remove: remove,
                append: append,
                parent: _root,
                view: widget.view,
                isChildren: false,
                textStyle: widget.textStyle?.copyWith(

                  fontFamily: _renderList[index].name_font_family !=''?_renderList[index].name_font_family: widget.textStyle?.fontFamily,

                  color:   _renderList[index].name_text_color !=''?  Color(int.parse(_renderList[index].name_text_color.substring(1, 7), radix: 16) + 0xFF000000):Colors.black,)
                 ??  TextStyle(

                    fontFamily: _renderList[index].name_font_family !=''?_renderList[index].name_font_family: widget.textStyle?.fontFamily,

                    color:   _renderList[index].name_text_color !=''?  Color(int.parse(_renderList[index].name_text_color.substring(1, 7), radix: 16) + 0xFF000000):Colors.black,),
                data: _renderList[index],
                icon: widget.icon,
                leftIcon: widget.leftIcon ?? Container(),
                rightIcon: widget.leftIcon ?? Container(),
                lazy: widget.lazy,
                offsetLeft: widget.offsetLeft,
                showCheckBox: widget.showCheckBox,
                showActions: widget.showActions,
                onTap: widget.onTap ?? (p,n) {},
                onLastTap: widget.onLastTap ?? (p,n) {},
                onLoad: widget.onLoad ?? (n) {},
                onCheck: widget.onCheck ?? (b, n) {},
                onExpand: widget.onExpand ?? (n) {},
                onRemove: widget.onRemove ?? (n, p) {},
                onAppend: widget.onAppend ?? (n, p) {},
                onCollapse: widget.onCollapse ?? (n) {},
              );
            },
          ),
        ],
      ),
    );

  }
}


class TreeViewHorizontal extends StatefulWidget {
  final List<TreeNodeData> data;
  final String selectedId;
  final bool view;
  final bool lazy;
  final TextStyle? textStyle;
  final Widget icon;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double offsetLeft;
  final bool showFilter;
  final bool showActions;
  final bool showCheckBox;

  final Function(TreeNodeData parent,TreeNodeData node)? onTap;
  final Function(TreeNodeData parent,TreeNodeData node)? onLastTap;
  final void Function(TreeNodeData node)? onLoad;
  final void Function(TreeNodeData node)? onExpand;
  final void Function(TreeNodeData node)? onCollapse;
  final void Function(bool checked, TreeNodeData node)? onCheck;
  final void Function(TreeNodeData node, TreeNodeData parent)? onAppend;
  final void Function(TreeNodeData node, TreeNodeData parent)? onRemove;

  final TreeNodeData Function(TreeNodeData parent)? append;
  final Future<List<TreeNodeData>> Function(TreeNodeData parent)? load;

  const TreeViewHorizontal({
    Key? key,
    required this.data,
    this.textStyle,
    this.onTap,
    this.onLastTap,
    this.leftIcon,
    this.rightIcon,
    this.onCheck,
    this.onLoad,
    this.onExpand,
    this.onCollapse,
    this.onAppend,
    this.onRemove,
    this.append,
    this.load,
    this.lazy = false,
    this.offsetLeft = 24.0,
    this.showFilter = false,
    this.showActions = false,
    this.showCheckBox = false,
    this.icon = const Icon(Icons.expand_more, size: 16.0),
    required this.view,
    required this.selectedId,
  }) : super(key: key);

  @override
  State<TreeViewHorizontal> createState() => _TreeViewHorizontalState();
}

class _TreeViewHorizontalState extends State<TreeViewHorizontal> {
  late TreeNodeData _root;
  List<TreeNodeData> _renderList = [];

  List<TreeNodeData> _filter(String val, List<TreeNodeData> list) {
    List<TreeNodeData> temp = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].title.contains(val)) {
        temp.add(list[i]);
      }
      if (list[i].children.isNotEmpty) {
        list[i].children = _filter(val, list[i].children);
      }
    }
    return temp;
  }

  void _onChange(String val) {
    if (val.isNotEmpty) {
      _renderList = _filter(val, _renderList);
    } else {
      _renderList = widget.data;
    }
    setState(() {});
  }

  void append(TreeNodeData parent) {
    parent.children.add(widget.append!(parent));
    setState(() {});
  }

  void _remove(TreeNodeData node, List<TreeNodeData> list) {
    for (int i = 0; i < list.length; i++) {
      if (node == list[i]) {
        list.removeAt(i);
      } else {
        _remove(node, list[i].children);
      }
    }
  }

  void remove(TreeNodeData node) {
    _remove(node, _renderList);
    setState(() {});
  }

  Future<bool> load(TreeNodeData node) async {
    try {
      final data = await widget.load!(node);
      node.children = data;
      setState(() {});
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _renderList = widget.data;
    _root = TreeNodeData(
      name: "",
      language: "",
      id: 0,
      sub_parent_id: "0",
      parent_id: "0",
      title: '',
      quote: '',
      name_text_color: '',
      name_font_family: '',
      quote_font_family: '',
      quote_text_color: '',
      isTop: false,
      extra: null,
      checked: false,
      expanded: false,
      children: _renderList,

    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showFilter)
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                bottom: 12.0,
              ),
              child: TextField(onChanged: _onChange),
            ),
          ...List.generate(
            _renderList.length,
                (int index) {
              return TreeNode(
                selectedId: widget.selectedId,
                load: load,
                remove: remove,
                append: append,
                parent: _root,
                view: widget.view,
                isChildren: false,
                textStyle:  widget.textStyle?.copyWith(

              fontFamily: _renderList[index].name_font_family !=''?_renderList[index].name_font_family: widget.textStyle?.fontFamily,

                color:   _renderList[index].name_text_color !=''?  Color(int.parse(_renderList[index].name_text_color.substring(1, 7), radix: 16) + 0xFF000000):Colors.black,)
                  ??  TextStyle(

                   fontFamily: _renderList[index].name_font_family !=''?_renderList[index].name_font_family: widget.textStyle?.fontFamily,

                    color:   _renderList[index].name_text_color !=''?  Color(int.parse(_renderList[index].name_text_color.substring(1, 7), radix: 16) + 0xFF000000):Colors.black,),
                data: _renderList[index],
                icon: widget.icon,
                leftIcon: widget.leftIcon ?? Container(),
                rightIcon: widget.leftIcon ?? Container(),
                lazy: widget.lazy,
                offsetLeft: widget.offsetLeft,
                showCheckBox: widget.showCheckBox,
                showActions: widget.showActions,
                onTap: widget.onTap ?? (p,n) {},
                onLastTap: widget.onLastTap ?? (p,n) {},
                onLoad: widget.onLoad ?? (n) {},
                onCheck: widget.onCheck ?? (b, n) {},
                onExpand: widget.onExpand ?? (n) {},
                onRemove: widget.onRemove ?? (n, p) {},
                onAppend: widget.onAppend ?? (n, p) {},
                onCollapse: widget.onCollapse ?? (n) {},
              );
            },
          ),
        ],
      ),
    );

  }
}