import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WFavoritesController extends GetxController {
  RxInt selectedIndex = 1.obs;
  RxInt selectedItem = 0.obs;
  String id = '';

  List myBoolList = [];

  RxList<bool> selectLike = <bool>[].obs;

  CollectionReference user = FirebaseFirestore.instance.collection('user');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  List imageList = [
    AssetRes.wallpaperpre1,
    AssetRes.wallpaperpre2,
    AssetRes.wallpaperpre3,
    AssetRes.wallpaperpre4,
    AssetRes.wallpaperpre5,
    AssetRes.wallpaperpre6,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectLike.value = List.generate(imageList.length, (index) => false);
  }

  onTapLikeUnlike(int index) async {
    List list = [];
    list.clear();
    await user.doc(PrefService.getString('docId')).get().then((value) {
      value['favourite'].forEach((element) {
        list.add({
          'image': element['image'],
          'isFav': element['isFav'],
        });
      });
      list.removeAt(index);
    });
    user.doc(PrefService.getString('docId')).update({'favourite': list});
// updateToCategory(image,isLike);
  }

  updateToCategory(String image, bool isLike) async {
    List cList = [];
    List list = [];
    var id = '';

    await category.get().then((value) {
      value.docs.forEach((e) {
        cList = e['image'];
        cList.forEach((element) {
          if (element['imageLink'] == image) {
            list.add({
              'imageLink': element['imageLink'],
              'isFav': isLike,
            });
            id = e.id;
          } else {
            list.add({
              'imageLink': element['imageLink'],
              'isFav': element['isFav'],
            });
          }
        });
      });
    });

    await category.doc(id).update({
      'image': list,
    });
  }
}
