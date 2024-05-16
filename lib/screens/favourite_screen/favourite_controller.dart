
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/services/sqlite_helper.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:wc_flutter_share/wc_flutter_share.dart';
class FavouriteController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  bool isPageView = false;
  String selectedLanguage="English";
  String languageCode ="en";

  List<bool> addSelectedImage = List.generate(4, (index) => false);

  RxBool loader = false.obs;


  List<String> settingTitleList = [
    StringRes.privacyPolicy.tr,
    StringRes.changePassword.tr,
    StringRes.deleteAccount.tr,
  ];



  List<String> settingImageList = [
    AssetRes.privacyPolicy,
    AssetRes.lockIcon,
    AssetRes.deleteAcountIcon,

  ];

  List<Map<String,dynamic>>? storedFavorites=[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // storedFavorites= PrefService.getList( PrefService.getString(PrefKeys.userId));
    init();
  }

  PageController pageController =PageController();
  int selectedIndex =0;
String? selectedImage ;
  onImageChanged(i){


    if(storedFavorites?[i]['image'] != null)
    {


      selectedIndex =  pageController.page!.round();

      selectedImage = storedFavorites![i]['image'].toString();

    }
    update(['favourite']);
  }

  onTapImage(index)async{
    isPageView = true;
    await Future.delayed(Duration(seconds: 1),(){});
    pageController =PageController(initialPage: index);
    selectedImage = storedFavorites![index]['image'].toString();
    update(['favourite']);
  }

  tapBackwardButton(){
    if(pageController.page!.round() != storedFavorites!.length - 1) {

      pageController.animateToPage(
          pageController.page!.round() +1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
    }
    update(['favourite']);
  }
  tapForwardButton(){
    if(pageController.page!.round() != 0) {
      pageController.animateToPage(
          pageController.page!.round() -1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
    }
    update(['fldr']);
  }



  saveImage(context)async{

    if(storedFavorites !=null && storedFavorites!.length !=0) {
      loader.value = true;


      var response = await Dio()
          .get(
          selectedImage ?? storedFavorites![0]['image'].toString(), options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "ra",
      );
      loader.value = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: AlertDialog(
                title:  Text(
                  "Success",
                  style: appTextStyle(
                      weight: FontWeight.w500, fontSize: 20, color: ColorRes.appColor),
                ),
                content:  Text(
                  "Images Downloaded Successfully",
                  style: appTextStyle(
                      color: ColorRes.black,
                      fontSize: 18,
                      weight: FontWeight.w600),
                ),
                actions: <Widget>[

                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          );
                        },
                      ),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: ColorRes.blue)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white),
                    ),
                    onPressed: () {
                      return Get.back();
                    },
                    child:  Text(
                      "Okay",
                      style: appTextStyle(
                          color: ColorRes.appColor,
                          fontSize: 18,
                          weight: FontWeight.w600),
                    ),
                  ),

                ],
              ),
            );
          }
      );
      selectedImage = null;

      // loader.value = true;
      //
      // simg.forEach((element) async{
      //   var response = await Dio()
      //       .get(element, options: Options(responseType: ResponseType.bytes));
      //   await ImageGallerySaver.saveImage(
      //     Uint8List.fromList(response.data),
      //     quality: 60,
      //     name: "ra",
      //   );
      // });
      // loader.value = false;

      // Get.snackbar(
      //   "Success",
      //   "Images Downloaded Successfully",
      //   backgroundColor: Colors.green,
      //   colorText: ColorRes.white,
      // );

      update(['favourite']);
    }

  }


  onTapShare()async{
    loader.value = true;

    if(storedFavorites !=null && storedFavorites!.length !=0) {

      try {
        http.Response response = await http.get(Uri.parse(
            selectedImage ?? storedFavorites![0]['image'].toString()));
        final bytes = response.bodyBytes;

        await WcFlutterShare.share(
            sharePopupTitle: 'share',
            fileName: "share.${selectedImage?.split(".").last ?? storedFavorites![0]['image'].toString().split(".").last}",
            mimeType: 'image/${selectedImage?.split(".").last ??
                storedFavorites![0]['image']
                    .toString()
                    .split(".")
                    .last}',
            bytesOfFile: bytes);
      }catch(e){

        loader.value = false;
      }
      // Share.share(selectedImage ?? getBoardInfoModel.data![0].image.toString(),);
      selectedImage = null;
      loader.value= false;

      update(['fldr']);
    }
  }

  init()async{
storedFavorites =[];
    var data  = await SqliteHelper.sqliteHelper.fetch();
   data.forEach((element) {
     storedFavorites?.add({
       "id":element.imageId,
       "image":element.imageUrl,
     });
   });

   update(['favourite']);
  }


  removeFavorite(id) async {
    await SqliteHelper.sqliteHelper.delete(imageID: id,);
   await  init();
    update(['favourite']);
    }

}
