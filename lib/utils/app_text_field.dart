import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

TextFormField appTextField(
    {TextEditingController? controller,
    bool? obscureText,
    bool? enabled,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? hintText,
    TextStyle? style,
      int? maxLines,
      double? contentPaddingTop,
    void Function(String)? onChanged,
    TextStyle? hintStyle}) {
  return TextFormField(
    obscureText: obscureText ?? false,
    onChanged: onChanged,
    style: style ?? TextStyle(color: ColorRes.black),
    enabled: enabled ?? true,

    keyboardType: keyboardType ?? TextInputType.text,
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: Get.width * 0.05,top: contentPaddingTop ?? 0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      prefixIcon: prefixIcon,
      suffixIcon:suffixIcon ,
      hintText: hintText,
      hintStyle: hintStyle,
    ),
  );
}
