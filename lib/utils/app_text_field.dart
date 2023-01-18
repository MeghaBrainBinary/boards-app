import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

TextFormField appTextField(
    {TextEditingController? controller,
    bool? obscureText,
    bool? enabled,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    String? hintText,
    TextStyle? style,
    void Function(String)? onChanged,
    TextStyle? hintStyle}) {
  return TextFormField(
    onChanged: onChanged,
    style: style ?? TextStyle(color: ColorRes.black),
    enabled: enabled ?? true,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType ?? TextInputType.text,
    controller: controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: Get.width * 0.05),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: hintStyle,
    ),
  );
}
