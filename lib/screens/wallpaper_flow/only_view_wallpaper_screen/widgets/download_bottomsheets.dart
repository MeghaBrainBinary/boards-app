import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/wallpaper_flow/only_view_wallpaper_screen/only_view_wallpaper_screen.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

downloadBottomSheetUi({required BuildContext context, imageLink}) {
  showModalBottomSheet<dynamic>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.066, right: Get.width * 0.066),
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Colors.white,
                ),
                width: Get.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DOWNLOAD',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        showDialogOfAds(context, imageLink);
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Portrait Adapted',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          Image.asset(
                            AssetRes.add,
                            scale: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        showDialogOfAds(context, imageLink);
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Original Size',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          Image.asset(
                            AssetRes.add,
                            scale: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      onTap: () {
                        Get.back();
                      },
                      width: Get.width,
                      text: StringRes.cancel,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
