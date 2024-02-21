import 'dart:math';

import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

class WallPaperScreen extends StatelessWidget {
  const WallPaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.06,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "WallPapers",
                  style: TextStyle(
                      fontSize: Get.width * 0.06,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "spleshfont"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Expanded(
            child: GridView.custom(
              padding: EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AssetRes.wallpaper1,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
