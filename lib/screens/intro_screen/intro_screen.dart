import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/intro_screen/intro_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _MyFolderScreenState();
}

class _MyFolderScreenState extends State<IntroScreen> {
  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        width: Get.width,

        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetRes.background),
              fit: BoxFit.fill,
            )
        ),
        child: GetBuilder<IntroController>(
          id: 'fldr',
          builder: (controller) => SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      height: Get.height * 0.5,
                      padding: const EdgeInsets.only(top: 34, right: 20),
                      width: Get.width,
                      color: ColorRes.skyWhiteBlue,
                      // child: Text(
                      //   StringRes.skip,
                      //   style: appTextStyle(
                      //       color: ColorRes.black,
                      //       weight: FontWeight.w400,
                      //       fontSize: 15),
                      // ),
                    ),
                    SizedBox(
                      height: Get.height * 0.25,
                    ),
                    Text(
                      controller.currentPage == 0
                          ? StringRes.seeEveryDetails.tr
                          : controller.currentPage == 1
                              ? StringRes.easilyShareImages.tr
                              : StringRes.click.tr,
                      textAlign: TextAlign.center,
                      style: appTextStyle(
                          color: ColorRes.black,
                          weight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.intoPhoneImages.length,
                      effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 12.0,
                        dotHeight: 04.0,
                        paintStyle: PaintingStyle.fill,
                        dotColor: ColorRes.colorBEBEBE,
                        activeDotColor: ColorRes.appColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CommonButton(
                        onTap: () {
                          if (introController.pageController.page ==
                              introController.intoPhoneImages.length - 1) {
                            // Navigate to a different screen when on the last page
                            Get.offAndToNamed(AppRoutes.languagePage);
                          } else {
                            // Navigate to the next page
                            introController.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                        text: controller.currentPage == 2
                            ? StringRes.getStarted.tr
                            : StringRes.next.tr),
                  ],
                ),
               // SizedBox(height: 30,),

                Stack(
                  children: [
                    Container(height: 10),
                    Container(
                      margin: EdgeInsets.only(top: Get.height * 0.07),
                      height: Get.height * 0.7,
                      child: PageView.builder(
                        controller: introController.pageController,
                        itemCount: introController.intoPhoneImages.length,
                        onPageChanged: (int page) {
                          controller.currentPage = page;
                          controller.update(['fldr']);
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            introController.intoPhoneImages[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed(AppRoutes.languagePage);
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    margin: EdgeInsets.only(top: Get.height * 0.07,   right: Get.width * 0.07),
                    alignment: Alignment.topRight,
                    child: Text(
                      StringRes.skip.tr,
                      style: appTextStyle(
                          color: ColorRes.black,
                          weight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
