import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDropDownController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<Map<String, dynamic>> categoriesList = [];

      for (var document in querySnapshot.docs) {
        categoriesList.add({
          'categoryId': document.id,
          'categoryName': document['categoryName'],
          'categoryImage': document['categoryImage'],
        });
      }

      categories.value = categoriesList;
      print(categories);
      update();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

//set selected category
  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print('selectedCategoryId $selectedCategoryId');
    update();
  }

  // Method to fetch category name based on category ID
  Future<String?> getCategoryName(String? categoryId) async {
    try {
      // Access Firestore collection and document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('categories')
          .doc(categoryId)
          .get();

      // Extract category name from snapshot
      if (snapshot.exists) {
        return snapshot.data()?['categoryName'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching category name: $e");
      return null;
    }
  }

  // set categoryName
  void setSelectedCategoryName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    print('selectedCategoryName $selectedCategoryName');
    update();
  }

  // set old value
  void setOldValue(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print('selectedCategoryId $selectedCategoryId');
    update();
  }
}



//   RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
//   RxString? selectCategoryId;
//   RxString? selectCategoryName;

//   @override
//   void onInit() {
//     fatchCategories();
//     super.onInit();
//   }

//   Future<void> fatchCategories() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await FirebaseFirestore.instance.collection('categories').get();

//       List<Map<String, dynamic>> categoriesList = [];
//       querySnapshot.docs
//           .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
//         categoriesList.add({
//           'categoryId': document.id,
//           'categoryName': document['categoryName'],
//           'categoryImage': document['categoryImage']
//         });
//       });

//       categories.value = categoriesList;
//       update();
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   // set selected category
//   void setSelectedCategory(String? categoryId) {
//     selectCategoryId = categoryId?.obs;
//     print("Selected categoryId $selectCategoryId");
//     update();
//   }

//   // fetch category Name

//   Future<String?> getCategoryName(String? categoryId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('categories')
//           .doc(categoryId)
//           .get();

//       if (snapshot.exists) {
//         return snapshot.data()?['categoryName'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("error $e");
//       return null;
//     }
//   }

//   void seleCategoryName(String? categoryName) {
//     selectCategoryName = categoryName?.obs;
//     print("select Category Name $selectCategoryName");
//   }
// }
