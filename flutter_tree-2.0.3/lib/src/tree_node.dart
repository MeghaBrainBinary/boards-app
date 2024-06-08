// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import '../flutter_tree.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class TreeNode extends StatefulWidget {
  String selectedId;
   TreeNodeData data;
  final TreeNodeData parent;
  final bool view;
  final bool lazy;
  final bool isChildren;
  final Widget icon;
  final Widget leftIcon;
  final Widget rightIcon;
  final bool showCheckBox;
  final bool showActions;
  final double offsetLeft;
  final TextStyle textStyle;

  final Function(TreeNodeData parent,TreeNodeData node) onTap;
  final Function(TreeNodeData parent,TreeNodeData node) onLastTap;
  final void Function(bool checked, TreeNodeData node) onCheck;

  final void Function(TreeNodeData node) onExpand;
  final void Function(TreeNodeData node) onCollapse;

  final Future Function(TreeNodeData node) load;
  final void Function(TreeNodeData node) onLoad;

  final void Function(TreeNodeData node) remove;
  final void Function(TreeNodeData node, TreeNodeData parent) onRemove;

  final void Function(TreeNodeData node) append;
  final void Function(TreeNodeData node, TreeNodeData parent) onAppend;

  TreeNode({
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
    required this.view,
    required this.selectedId,
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

  List<TreeNode> _geneTreeNodes(List list, isChildren) {
    return List.generate(list.length, (int index) {
      return TreeNode(
        view: widget.view,
        textStyle: TextStyle(
fontSize: 14,
            fontFamily: list[index].name_font_family !=''?list[index].name_font_family: widget.textStyle.fontFamily,

            color:   list[index].name_text_color !=''?  Color(int.parse(list[index].name_text_color.substring(1, 7), radix: 16) + 0xFF000000):Colors.black,),
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
        selectedId: widget.selectedId,
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
    if (_isExpaned) {
      _rotationController.forward();
    }
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
                    print("-------------- id ---------------${widget.selectedId}");
                    print("-------------- id ---------------${widget.data.id}");
                    widget.onLastTap(widget.parent,widget.data);
                    // widget.load(widget.data).then((value) {
                    //   if (value) {
                    //     _rotationController.forward();
                    //     widget.onLoad(widget.data);
                    //   }
                    //   _showLoading = false;
                    //   setState(() {});
                    // });
                  } else {
                    // widget.onTap(widget.data);
                    // _isExpaned = !_isExpaned;
                    // if (_isExpaned) {
                    //   _rotationController.forward();
                    // } else {
                    //   _rotationController.reverse();
                    // }

                   // _isExpaned = !_isExpaned;
                    // if(!_isExpaned) {
                    //   widget.onTap(widget.data);
                    // }


                    _isExpaned = !_isExpaned;
                    if (_isExpaned) {
                      _rotationController.forward();
                    } else {
                      _rotationController.reverse();

                    }
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
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: widget.view
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: (widget.selectedId == (widget.data.id ?? "").toString()) ? ColorRes.appColor : ColorRes.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: ColorRes.appColor)
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            widget.onTap(widget.parent,widget.data);
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 36,
                                            alignment: Alignment.center,
                                            child: CachedNetworkImage(
                                              height: 24,
                                              width: 24,
                                              imageUrl: widget.data.icon ?? "",
                                              progressIndicatorBuilder: (context, strings, download) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.white,
                                                  enabled: true,
                                                  child: Container(
                                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                );
                                              },
                                              errorWidget: (context, url, error) => const SizedBox(height: 15, width: 15),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child:     HtmlWidget(
                                            widget.data.title,
                                            renderMode: RenderMode.column,
                                            textStyle:widget.textStyle,

                                          ), ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          widget.onTap(widget.parent,widget.data);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 46,
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                            height: 40,
                                            width: 46,
                                            imageUrl: widget.data.icon ?? "",
                                            progressIndicatorBuilder: (context, strings, download) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.white,
                                                enabled: true,
                                                child: Container(
                                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              );
                                            },
                                            errorWidget: (context, url, error) => const SizedBox(height: 15, width: 15),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      // Text(widget.data.title, style: widget.textStyle),
                                      HtmlWidget(
    widget.data.title,
                                        textStyle:widget.textStyle,
                                      ),
                                    ],
                                  ),
                          ),
                          (widget.isChildren == false)
                              ? (widget.data.isTop == true)
                                  ? (widget.leftIcon != null)
                                      ? Column(
                                          children: const [
                                            // widget.leftIcon!,
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
                          child: const Text('Add',
                              style: TextStyle(fontSize: 12.0)),
                        ),
                      if (widget.showActions)
                        TextButton(
                          onPressed: () {
                            widget.remove(widget.data);
                            widget.onRemove(widget.data, widget.parent);
                          },
                          child: const Text('Remove',
                              style: TextStyle(fontSize: 12.0)),
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

                true,
              ),
            ),
          ),
        )
      ],
    );
  }
}
