// ignore_for_file: must_be_immutable

import 'package:boards_app/utils/asset_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WallPaperPreviewScreen extends StatelessWidget {
  String image;

  WallPaperPreviewScreen({Key? key, required this.image}) : super(key: key);

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: CachedNetworkImage(
                height: Get.height,
                width: Get.width,
                imageUrl: image,
                fit: BoxFit.fill,
                placeholder: (context, url) => Image.asset(
                  AssetRes.imagePlaceholder,
                  fit: BoxFit.fill,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AssetRes.imagePlaceholder,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 2,
              carouselController: buttonCarouselController,
              itemBuilder: (context, index, realIndex) {
                return index == 0
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.wp,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "WhatsApp",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.xrecord,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "xRecorder",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.fb,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "instagram",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.telegram,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "telegram",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.skyp,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Skype",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.cinema,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "jioCinema",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.docs,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "docs",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.gpay,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "GPay",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.youtube,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "videos",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.playstore,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "PlayStore",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.snapchat,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "snapChat",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.phone,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Phone",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.clock,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Clock",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.gallery,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.setting,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Setting",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.flamingo,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Flamingo",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.jio,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "Jio",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.asset(
                                    AssetRes.pubg,
                                    width: 55,
                                    height: 55,
                                  )),
                                  const Text(
                                    "PubG",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
              },
              options: CarouselOptions(
                  onPageChanged: (index, reason) {},
                  enableInfiniteScroll: false,
                  height: double.infinity,
                  initialPage: 0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1),
            ),
          ],
        ),
      ),
    );
  }
}
