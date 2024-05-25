import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(35),
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                  color: ColorRes.white, borderRadius: BorderRadius.circular(25)),
              child:  CircularProgressIndicator(
                backgroundColor:const Color(0xffE2D3FE),
                color: ColorRes.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
