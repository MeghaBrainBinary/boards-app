// ignore_for_file: must_be_immutable

import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {

  GestureTapCallback? onTap;
  String? text;
  double? width;
  double? height;
   CommonButton({super.key,
    this.onTap,
     this.text,
     this.height,
     this.width
});




  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50,
        width: width ?? 234,
        decoration: BoxDecoration(
          color: ColorRes.appColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text ?? "",
          style: appTextStyle(fontSize: 18, weight: FontWeight.w600),
        ),
      ),
    );
  }
}
