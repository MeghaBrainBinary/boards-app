// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages
import 'package:flutter/material.dart';
import '../flutter_tree.dart';
import 'package:google_fonts/google_fonts.dart';

class TreeNode extends StatefulWidget {
  final TreeNodeData data;
  final TreeNodeData parent;

  final bool lazy;
  final bool isChildren;
  final Widget icon;
  final Widget leftIcon;
  final Widget rightIcon;
  final bool showCheckBox;
  final bool showActions;
  final double offsetLeft;
  final TextStyle textStyle;

  final Function(TreeNodeData node) onTap;
  final Function(TreeNodeData node) onLastTap;
  final void Function(bool checked, TreeNodeData node) onCheck;

  final void Function(TreeNodeData node) onExpand;
  final void Function(TreeNodeData node) onCollapse;

  final Future Function(TreeNodeData node) load;
  final void Function(TreeNodeData node) onLoad;

  final void Function(TreeNodeData node) remove;
  final void Function(TreeNodeData node, TreeNodeData parent) onRemove;

  final void Function(TreeNodeData node) append;
  final void Function(TreeNodeData node, TreeNodeData parent) onAppend;

  const TreeNode({
    Key? key,
    required this.data,
    this.isChildren = false,
    required this.leftIcon,
    required this.rightIcon,
    required this.parent,
    required this.offsetLeft,
    required this.showCheckBox,
    required this.showActions,
    required this.icon,
    required this.lazy,
    required this.load,
    required this.append,
    required this.remove,
    required this.onTap,
    required this.onLastTap,
    required this.onCheck,
    required this.onLoad,
    required this.onExpand,
    required this.onAppend,
    required this.onRemove,
    required this.onCollapse,
    required this.textStyle,
  }) : super(key: key);

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode>
    with SingleTickerProviderStateMixin {
  bool _isExpaned = false;
  bool _isChecked = false;
  bool _showLoading = false;
  Color _bgColor = Colors.transparent;
  late AnimationController _rotationController;
  final Tween<double> _turnsTween = Tween<double>(begin: -0.25, end: 0.0);

  List<TreeNode> _geneTreeNodes(List list, textStyle, isChildren) {
    return List.generate(list.length, (int index) {
      return TreeNode(
        textStyle: textStyle,
        data: list[index],
        parent: widget.data,
        remove: widget.remove,
        append: widget.append,
        isChildren: isChildren ?? false,
        icon: widget.icon,
        leftIcon: widget.leftIcon,
        rightIcon: widget.rightIcon,
        lazy: widget.lazy,
        load: widget.load,
        offsetLeft: widget.offsetLeft,
        showCheckBox: widget.showCheckBox,
        showActions: widget.showActions,
        onTap: widget.onTap,
        onCheck: widget.onCheck,
        onExpand: widget.onExpand,
        onLoad: widget.onLoad,
        onCollapse: widget.onCollapse,
        onRemove: widget.onRemove,
        onAppend: widget.onAppend,
        onLastTap: widget.onLastTap,
      );
    });
  }

  @override
  initState() {
    super.initState();
    _isExpaned = widget.data.expanded;
    _isChecked = widget.data.checked;
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onExpand(widget.data);
        } else if (status == AnimationStatus.reverse) {
          widget.onCollapse(widget.data);
        }
      });
    // if (_isExpaned) {
      _rotationController.forward();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MouseRegion(
          onHover: (event) {},
          onEnter: (event) {
            _bgColor = Colors.grey[200]!;
            setState(() {});
          },
          onExit: (event) {
            _bgColor = Colors.transparent;
            setState(() {});
          },
          child: Container(
            color: _bgColor,
            margin: const EdgeInsets.only(bottom: 2.0),
            padding: const EdgeInsets.only(right: 12.0),
            child: Tooltip(
              waitDuration: const Duration(microseconds: 0),
              showDuration: const Duration(seconds: 1),
              triggerMode: TooltipTriggerMode.longPress,
              textAlign: TextAlign.left,
              preferBelow: false,
              message: widget.data.title,
              child: InkWell(
                onTap: () {
                  if (widget.lazy || widget.data.children.isEmpty) {
                    setState(() {
                      _showLoading = true;
                    });
                    // _isExpaned = false;
                    widget.onLastTap(widget.data);
                    // widget.load(widget.data).then((value) {
                    //   if (value) {
                    //     _rotationController.forward();
                    //     widget.onLoad(widget.data);
                    //   }
                    //   _showLoading = false;
                    //   setState(() {});
                    // });
                  } else {
                    widget.onTap(widget.data);
                    // _isExpaned = !_isExpaned;
                    // if (_isExpaned) {
                    //   _rotationController.forward();
                    // } else {
                    //   _rotationController.reverse();
                    // }
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      // RotationTransition(
                      //   turns: _turnsTween.animate(_rotationController),
                      //   child: IconButton(
                      //     iconSize: 16,
                      //     icon: widget.icon,
                      //     onPressed: () {
                      //
                      //       if (widget.lazy || widget.data.children.isEmpty) {
                      //         setState(() {
                      //           _showLoading = true;
                      //         });
                      //         _isExpaned = false;
                      //       }
                      //       else {
                      //         _isExpaned = !_isExpaned;
                      //         if (_isExpaned) {
                      //           _rotationController.forward();
                      //         } else {
                      //           _rotationController.reverse();
                      //         }
                      //         setState(() {});
                      //       }
                      //
                      //     },
                      //   ),
                      // ),

                      const SizedBox(width: 10),

                      if (widget.showCheckBox)
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            _isChecked = value!;
                            widget.onCheck(_isChecked, widget.data);
                            setState(() {});
                          },
                        ),
                      if (widget.lazy && _showLoading)
                        const SizedBox(
                          width: 12.0,
                          height: 12.0,
                          child: CircularProgressIndicator(strokeWidth: 1.0),
                        ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 20),
                            child: Text(widget.data.title, style: widget.textStyle),
                          ),
                          (widget.isChildren == false)
                              ? (widget.data.isTop == true)
                                  ? (widget.leftIcon != null)
                                      ? Column(
                                          children: [
                                            widget.leftIcon!,
                                            // const SizedBox(height: 10)
                                          ],
                                        )
                                      : const SizedBox()
                                  : const SizedBox()
                              : const SizedBox(),
                        ],
                      ),
                      if (widget.showActions)
                        TextButton(
                          onPressed: () {
                            widget.append(widget.data);
                            widget.onAppend(widget.data, widget.parent);
                          },
                          child: const Text('Add', style: TextStyle(fontSize: 12.0)),
                        ),
                      if (widget.showActions)
                        TextButton(
                          onPressed: () {
                            widget.remove(widget.data);
                            widget.onRemove(widget.data, widget.parent);
                          },
                          child: const Text('Remove', style: TextStyle(fontSize: 12.0)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _rotationController,
          child: Padding(
            padding: EdgeInsets.only(left: widget.offsetLeft),
            child: Column(
              children: _geneTreeNodes(
                widget.data.children,
                GoogleFonts.inter(color: Colors.black.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.w400),
                true,
              ),
            ),
          ),
        )
      ],
    );
  }
}
