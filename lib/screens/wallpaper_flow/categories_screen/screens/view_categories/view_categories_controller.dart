import 'package:boards_app/services/pref_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewCategoryController extends GetxController {
  List myBoolList = [];

  Future<void> onTapCatImage2(String docId, length) async {
    myBoolList = [];
    myBoolList = List.generate(length, (index) => false);

    var myFavList = [];
    var myCategoryList = [];
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    CollectionReference category =
        FirebaseFirestore.instance.collection('category');

    if (PrefService.getString('docId') != '') {
      await user.doc(PrefService.getString('docId')).get().then((value) {
        myFavList = [];
        for (int i = 0; i < value['favourite'].length; i++) {
          myFavList.add(value['favourite'][i]['image']);
        }
      });

      await category.doc(docId).get().then((value) {
        myCategoryList = [];
        var list = value['image'];

        for (int i = 0; i < list.length; i++) {
          myCategoryList.add(list[i]['imageLink']);
        }
      });

      for (int i = 0; i < myCategoryList.length; i++) {
        for (int j = 0; j < myFavList.length; j++) {
          if (myCategoryList[i] == myFavList[j]) {
            myBoolList[i] = true;
          } else {}
        }
      }
    } else {}
  }
}
