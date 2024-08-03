import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/conts/consts.dart';
import '../conts/const_list.dart';
import '../models/categories.dart';
import '../widgets/mormat_text.dart';
import 'add_category.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: redColor,
        onPressed: () {
          Get.to(() => const AddCategoryScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "All Categories",
          //  productModel.productName.toString(),
          fontFamily: semibold,
          fontsize: 16,
        ),
        actions: [
          Center(
            child: NormalText(
                fontFamily: semibold,
                fontsize: 12,
                color: const Color(0xff000000),
                title1: DateFormat('yyyy-MM-dd-kk:mm').format(DateTime.now())),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("categories")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child:
                    NormalText(color: redColor, title1: "Users not fatching"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: NormalText(color: redColor, title1: "Users not found"),
              ),
            );
          }
          if (snapshot.data!.docs.isNotEmpty && snapshot.data!.docs != 'null') {
            final data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    final categoryData = snapshot.data!.docs[index];

                    CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: categoryData['categoryId'],
                      categoryImage: categoryData['categoryImage'],
                      categoryName: categoryData['categoryName'],
                      createdAt: categoryData['createdAt'],
                      updatedAt: categoryData['updatedAt'],
                    );

                    return Card(
                      elevation: 5,
                      child: SwipeActionCell(
                        key: ObjectKey(categoriesModel.categoryId),
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                              title: "Delete",
                              onTap: (CompletionHandler handler) async {
                                await Get.defaultDialog(
                                  title: "Delete Product",
                                  content: const Text(
                                      "Are you sure you want to delete this product?"),
                                  textCancel: "Cancel",
                                  textConfirm: "Delete",
                                  contentPadding: const EdgeInsets.all(10.0),
                                  confirmTextColor: Colors.white,
                                  onCancel: () {},
                                  onConfirm: () async {
                                    Get.back(); // Close the dialog
                                    // EasyLoading.show(status: 'Please wait..');

                                    await deleteImagesFromFirebase(
                                      categoriesModel.categoryImage,
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('categories')
                                        .doc(categoriesModel.categoryId)
                                        .delete();

                                    // EasyLoading.dismiss();
                                  },
                                  buttonColor: Colors.red,
                                  cancelTextColor: Colors.black,
                                );
                              },
                              color: Colors.red),
                        ],
                        child: ListTile(
                          onTap: () {
                            // Get.to(
                            //   () => ProductDetailScreen(
                            //       productModel: productModel),
                            // );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              categoriesModel.categoryImage[0].toString(),
                            ),
                          ),
                          title: NormalText(
                              fontFamily: semibold,
                              color: darkFontGrey,
                              fontsize: 12,
                              title1: categoriesModel.categoryName),
                          // subtitle: NormalText(
                          //     color: fontGrey,
                          //     fontsize: 12,
                          //     title1: ' ${productModel.fullPrice}'),

                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              print(value);
                            },
                            itemBuilder: (
                              BuildContext context,
                            ) {
                              return List.generate(
                                popupMenuTitles.length,
                                (index) => PopupMenuItem(
                                  value: popupMenuTitles[index],
                                  onTap: () {
                                    // final editProductCategory =
                                    //     Get.put(CategoryDropDownController());
                                    // editProductCategory
                                    //     .setOldValue(productMode.categoryId);
                                    // final isSaleController =
                                    //     Get.put(IsSaleController());
                                    // isSaleController
                                    //     .setIsSaleoldValue(productModel.isSale);
                                    switch (popupMenuTitles[index]) {
                                      case 'Edit':
                                        // Get.to(
                                        //   () => EditProductScreen(
                                        //       productModel: productModel),
                                        // );
                                        break;
                                      case 'Remove':
                                        break;
                                      default:
                                        const SizedBox.shrink();
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      popupMenuTitlesIcon[index],
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NormalText(
                                          color: fontGrey,
                                          title1: popupMenuTitles[index])
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future deleteImagesFromFirebase(List imagesUrl) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    for (String imgUrl in imagesUrl) {
      try {
        Reference reference = storage.refFromURL(imgUrl);
        await reference.delete();
      } catch (e) {
        print("Error $e");
      }
    }
  }
}
