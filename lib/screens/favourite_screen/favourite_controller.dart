
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/services/sqlite_helper.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
