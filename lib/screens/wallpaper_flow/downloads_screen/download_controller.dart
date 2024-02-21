import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DownloadController extends GetxController {
  List images = [];
  List imageFinalList = [];
  List myBoolList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    imageFinalList = [];
    images = PrefService.getList(PrefKeys.downloadImageList);
    for (int i = 0; i < images.length; i++) {
      imageFinalList.add({
        'imageLink': images[i],
        'isFav': false,
      });
    }
    super.onInit();
  }

  Future<void> onTapDownloadImage2(length) async {
    myBoolList = [];

    myBoolList = List.generate(length, (index) => false);

    var myFavList = [];
    var myDownloadList = [];
    CollectionReference user = FirebaseFirestore.instance.collection('user');

    if (PrefService.getString('docId') != '') {
      await user.doc(PrefService.getString('docId')).get().then((value) {
        myFavList = [];
        for (int i = 0; i < value['favourite'].length; i++) {
          myFavList.add(value['favourite'][i]['image']);
        }
      });

      myDownloadList = [];

      for (int i = 0; i < images.length; i++) {
        myDownloadList.add(images[i]);
      }

      for (int i = 0; i < myDownloadList.length; i++) {
        for (int j = 0; j < myFavList.length; j++) {
          if (myDownloadList[i] == myFavList[j]) {
            myBoolList[i] = true;
          } else {}
        }
      }
    } else {}
  }
}
