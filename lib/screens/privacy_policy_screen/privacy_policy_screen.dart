import 'package:boards_app/screens/privacy_policy_screen/privacy_policy_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  PrivacyPolicyController privacyPolicyController = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<PrivacyPolicyController>(
            id: "PrivacyPolicy",
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.025),
                    appBar(boardName: StringRes.privacyPolicy),
                    SizedBox(height: Get.height * 0.03),
                    Expanded(
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: Get.height * 0.03),
                          Text(
                            '''
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pellentesque aliquamvelit in rhoncus. Integer placerat urna ligula, vel dapibus enim congue et. In auctor auguesit amet sem mollis, nec malesuada midictum. Mauris metus diam, vulputate etpretium nec, vulputate id nunc. Nullambibendum, nibh in rutrum condimentum,arcu mauris imperdiet ligula, sed pharetraante massa sit amet mi. Ut feugiat quislibero at malesuada. In facilisis portaaliquam. Curabitur purus odio, iaculis egetdiam eu, pharetra suscipit ipsum
      ''',
                            textAlign: TextAlign.left,
                            style: appTextStyle(color: Colors.black,fontSize: 16,weight: FontWeight.w400),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            '''
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pellentesque aliquamvelit in rhoncus. Integer placerat urna ligula, vel dapibus enim congue et. In auctor auguesit amet sem mollis, nec malesuada midictum. Mauris metus diam, vulputate etpretium nec, vulputate id nunc. Nullambibendum, nibh in rutrum condimentum,arcu mauris imperdiet ligula, sed pharetraante massa sit amet mi. Ut feugiat quislibero at malesuada. In facilisis portaaliquam. Curabitur purus odio, iaculis egetdiam eu, pharetra suscipit ipsum
      ''',
                            textAlign: TextAlign.left,
                            style: appTextStyle(color: Colors.black,fontSize: 16,weight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  appBar({String? boardName}) {


    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(
        left: Get.width * 0.05,
        right: Get.width * 0.05,
      ),
      height: Get.height * 0.18,
      width: Get.width,
      // color: ColorRes.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {

            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text(
            boardName ?? '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
          Text(
             '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
        ],
      ),
    );
  }
}
