import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:kmart_admin/models/categories.dart';

class EditCategoriesController extends GetxController {
  CategoriesModel categoriesModel;
  EditCategoriesController({required this.categoriesModel});
  Rx<String> images = ''.obs;

  @override
  void onInit() {
    getRealTimeCategoryImage();
    super.onInit();
  }

  void getRealTimeCategoryImage() {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(categoriesModel.categoryId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data['categoryImage'] != null) {
          images.value = data['categoryImage'][0].toString();
          update();
        }
      }
    });
  }

  // delete images
  Future deleteImagesFromStorage(String imageurl) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      Reference reference = storage.refFromURL(imageurl);
      await reference.delete();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> deleteImagesFromFireStore(String imgUrl, String catId) async {
    try {
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(catId)
          .update({"categoryImage": ''});
      update();
    } catch (e) {
      print("error $e");
    }
  }
}
