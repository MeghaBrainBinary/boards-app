// ignore_for_file: must_be_immutable

import 'package:boards_app/screens/view/view_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ViewImagesScreen extends StatelessWidget {
   ViewImagesScreen({Key? key}) : super(key: key);
ViewImageController viewImageController = Get.put(ViewImageController());
  @override
  Widget build(BuildContext context) {
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

  decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AssetRes.background),
        fit: BoxFit.fill,
      )
  ),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:   GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: viewImageController.images.length,
            (context, index) => InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.viewFullImagesScreen,arguments:viewImageController.images[index].image!.toString());
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black,width: 4)
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,

                  imageUrl:viewImageController.images[index].image!.toString(),

                  progressIndicatorBuilder: (context,strings,download){
                    return    Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        enabled: true, child:
                    Container(
                      height: Get.width,width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                      ),
                    ));
                  },
                  errorWidget: (context, url, error) => Container(),
                ),
              ),
            ),
      ),

        ),
  ),
),

    );
  }
}
/*
 MasonryGridView.count(
    itemCount: viewImageController.images.length,
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 20,
    itemBuilder: (context, index) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
  border: Border.all(color: Colors.black,width: 4)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,

            imageUrl:viewImageController.images[index].image!.toString(),

            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => Container(),
          ),
        ),
      );
    },
  ),
 */