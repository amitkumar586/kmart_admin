import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/controllers/category_dropdown_controller.dart';
import 'package:kmart_admin/controllers/is_sale_controller.dart';
import 'package:kmart_admin/conts/const_list.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/models/product_model.dart';
import 'package:kmart_admin/products/add_product_screen.dart';
import '../widgets/mormat_text.dart';
import 'edit_product_screen.dart';
import 'product_detail_screen.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: redColor,
        onPressed: () {
          Get.to(() => const AddProductScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Product",
          fontFamily: semibold,
          fontsize: 16,
        ),
        actions: [
          Center(
            child: NormalText(
                fontFamily: semibold,
                fontsize: 12,
                color: const Color(0xff000000),
                title1:
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("products")
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
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                      categoryId: productData['categoryId'],
                      categoryName: productData['categoryName'],
                      deliveryTime: productData['deliveryTime'],
                      fullPrice: productData['fullPrice'],
                      productDescription: productData['productDescription'],
                      productId: productData['productId'],
                      productImages: productData['productImages'],
                      productName: productData['productName'],
                      salePrice: productData['salePrice'],
                      updatedAt: productData['updatedAt'],
                      createdAt: productData['createdAt'],
                      isSale: productData['isSale'],
                    );

                    return Card(
                      elevation: 5,
                      child: SwipeActionCell(
                        key: ObjectKey(productModel.productId),
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
                                      productModel.productImages,
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(productModel.productId)
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
                            Get.to(
                              () => ProductDetailScreen(
                                  productModel: productModel),
                            );
                          },
                          leading: Image.network(
                            productModel.productImages[0].toString(),
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          title: NormalText(
                              fontFamily: semibold,
                              color: darkFontGrey,
                              fontsize: 12,
                              title1: productModel.productName),
                          subtitle: NormalText(
                              color: fontGrey,
                              fontsize: 12,
                              title1: ' ${productModel.fullPrice}'),
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
                                    final editProductCategory =
                                        Get.put(CategoryDropDownController());
                                    editProductCategory
                                        .setOldValue(productModel.categoryId);
                                    final isSaleController =
                                        Get.put(IsSaleController());
                                    isSaleController
                                        .setIsSaleOldValue(productModel.isSale);
                                    switch (popupMenuTitles[index]) {
                                      case 'Edit':
                                        Get.to(
                                          () => EditProductScreen(
                                              productModel: productModel),
                                        );
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
                    // return
                    // Card(
                    //   elevation: 5,
                    //   child: ListTile(
                    //     onTap: () {
                    //       Get.to(() =>
                    //           ProductDetailScreen(productModel: productModel));
                    //     },
                    //     leading: Image.network(
                    //       productModel.productImages[0].toString(),
                    //       width: 200,
                    //       height: 180,
                    //       fit: BoxFit.cover,
                    //     ),
                    //     title: NormalText(
                    //         fontFamily: semibold,
                    //         color: darkFontGrey,
                    //         fontsize: 12,
                    //         title1: productModel.productName),
                    //     subtitle: NormalText(
                    //         color: fontGrey,
                    //         fontsize: 12,
                    //         title1: ' ${productModel.fullPrice}'),
                    //     trailing: PopupMenuButton(
                    //       onSelected: (value) {
                    //         print(value);
                    //       },
                    //       itemBuilder: (
                    //         BuildContext context,
                    //       ) {
                    //         return List.generate(
                    //           popupMenuTitles.length,
                    //           (index) => PopupMenuItem(
                    //             value: popupMenuTitles[index],
                    //             onTap: () {
                    //               final editProductCategory =
                    //                   Get.put(CategoryDropDownController());
                    //               editProductCategory
                    //                   .setOldValue(productModel.categoryId);
                    //               final isSaleController =
                    //                   Get.put(IsSaleController());
                    //               isSaleController
                    //                   .setIsSaleoldValue(productModel.isSale);
                    //               switch (popupMenuTitles[index]) {
                    //                 case 'Edit':
                    //                   Get.to(
                    //                     () => EditProductScreen(
                    //                         productModel: productModel),
                    //                   );
                    //                   break;
                    //                 case 'Remove':
                    //                   break;
                    //                 default:
                    //                   SizedBox.shrink();
                    //               }
                    //             },
                    //             child: Row(
                    //               children: [
                    //                 popupMenuTitlesIcon[index],
                    //                 const SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 NormalText(
                    //                     color: fontGrey,
                    //                     title1: popupMenuTitles[index])
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // );
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
