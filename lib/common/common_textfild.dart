// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextFeild extends StatelessWidget {


  bool? isShowViciblity;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapIcon;
  final ValueChanged<String>? onChanged;
  TextEditingController? controller;
  String? hintText;
  String? PrefixIcon;
   bool? obscureText;
   double? contentPaddingTop;

  CommonTextFeild({super.key,
    this.onTap,
    this.isShowViciblity,
    this.onTapIcon,
    this.onChanged,
  this.controller,
    this.hintText,
    this.PrefixIcon,
    this.obscureText,
    this.contentPaddingTop
});




  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child:  Container(
        height: Get.height * 0.075,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ColorRes.colorD9D9D9)),
        child: TextField(
          onChanged: onChanged,
          controller:controller ,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              hintText: hintText,
    contentPadding: EdgeInsets.only(left: Get.width * 0.05,top: contentPaddingTop ?? 0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              hintStyle: appTextStyle(
                color: ColorRes.black.withOpacity(0.3),
                fontSize: 13,
                weight: FontWeight.w400,
              ),
              suffixIcon: isShowViciblity == true
                  ? GestureDetector(
                onTap: onTapIcon,
                child: (obscureText == true)
                    ? const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                )
                    : const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.grey,
                ),
              )
                  : const SizedBox(),
              prefixIcon: Image.asset(
                PrefixIcon ?? "",
                scale: 3.5,
              )),
          ),

        ),
      );

  }
}
