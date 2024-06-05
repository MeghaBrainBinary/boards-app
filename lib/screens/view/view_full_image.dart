import 'package:boards_app/utils/asset_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ViewFullImageScreen extends StatelessWidget {

   ViewFullImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var image =  Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:   InkWell(
          onTap: () {

            Get.back();

          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,

        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetRes.background),
              fit: BoxFit.fill,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: DeviceFrame(

            device: Devices.ios.iPhone13ProMax,
            isFrameVisible: true,
            orientation: Orientation.portrait,
            screen: CachedNetworkImage(
              height: Get.height,
              width: Get.width,
              fit: BoxFit.fitWidth,
              imageUrl:image!.toString(),
              errorWidget: (context, url, error) => Container(),
              progressIndicatorBuilder: (context,strings,download){
                return    Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    enabled: true, child:
                Container(
                  height: Get.width,width: Get.width,
                  color: Colors.white,
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
