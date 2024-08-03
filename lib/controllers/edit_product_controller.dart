import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class EditProductController extends GetxController {
  ProductModel productModel;
  EditProductController({required this.productModel});
  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    getRealTimeImage();

    super.onInit();
  }

  void getRealTimeImage() {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.productId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data['productImages'] != null) {
          images.value =
              List<String>.from(data['productImages'] as List<dynamic>);
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

  Future<void> deleteImagesFromFireStore(
      String imgUrl, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .update({
        "productImages": FieldValue.arrayRemove([imgUrl])
      });
      update();
    } catch (e) {
      print("error $e");
    }
  }
}
