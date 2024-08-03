// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kmart_admin/controllers/edit_categories_controller.dart';
// import 'package:kmart_admin/models/categories.dart';

// import '../controllers/category_dropdown_controller.dart';
// import '../controllers/is_sale_controller.dart';
// import '../conts/colors.dart';
// import '../conts/styles.dart';
// import '../models/product_model.dart';
// import '../widgets/custom_text_field.dart';
// import '../widgets/mormat_text.dart';

// class CategorireEditScreen extends StatelessWidget {
//   final CategoriesModel categoriesModel;
//   const CategorireEditScreen({
//     super.key,
//     required this.categoriesModel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     IsSaleController isSaleController = Get.put(IsSaleController());

//     TextEditingController productNameController = TextEditingController();
//     TextEditingController salePriceController = TextEditingController();
//     TextEditingController fullPriceController = TextEditingController();
//     TextEditingController deliveryTimeController = TextEditingController();
//     TextEditingController productDescriptionController =
//         TextEditingController();

//     return GetBuilder<EditCategoriesController>(
//       init: EditCategoriesController(categoriesModel: categoriesModel),
//       builder: (editCategory) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: whiteColor,
//             title: NormalText(
//               color: const Color(0xff000000),
//               title1: categoriesModel.categoryName.toString(),
//               fontFamily: semibold,
//               fontsize: 16,
//             ),
//             actions: [
//               Center(
//                 child: NormalText(
//                     fontFamily: semibold,
//                     fontsize: 12,
//                     color: const Color(0xff000000),
//                     title1:
//                         DateFormat('yyyy-MM-dd-kk:mm').format(DateTime.now())),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GetBuilder(
//                   init: EditCategoriesController(
//                       categoriesModel: categoriesModel),
//                   builder: (editCategory) {
//                     return Stack(
//                       children: [
//                         Image.network(
//                           editCategory.images.value,
//                           fit: BoxFit.cover,
//                           width: Get.width / 2,
//                           height: Get.height / 4,
//                         ),
//                         Positioned(
//                           right: 10,
//                           top: 0,
//                           child: InkWell(
//                             onTap: () async {
//                               await editCategory.deleteImagesFromStorage(
//                                   editCategory.images.value.toString());
//                               await editCategory.deleteImagesFromFireStore(
//                                   editCategory.images.value.toString(),
//                                   categoriesModel.categoryId);
//                               // picController.removeImages(index);
//                             },
//                             child: CircleAvatar(
//                               child: Icon(
//                                 Icons.close,
//                                 color: redColor,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),

//                 // GetBuilder<IsSaleController>(
//                 //     init: IsSaleController(),
//                 //     builder: (isSaleController) {
//                 //       return Card(
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.all(8),
//                 //           child: Row(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               NormalText(color: fontGrey, title1: "isSale"),
//                 //               Switch(
//                 //                 value: isSaleController.isSale.value,
//                 //                 activeColor: redColor,
//                 //                 onChanged: (value) {
//                 //                   isSaleController.toggleIsSale(value);
//                 //                 },
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );
//                 //     }),

//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Form(
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         textEditingController: productNameController
//                           ..text = categoriesModel.categoryName,
//                         labelText: "Category Name",
//                         hintText: "Product Name",
//                       ),

//                       ElevatedButton(
//                         onPressed: () async {
//                           // CategoriesModel newcategoriesModel =
//                           //     CategoriesModel(
//                           //         categoryId: categoryId,
//                           //         categoryImage: categoryImage,
//                           //         categoryName: categoryName,
//                           //         createdAt: createdAt,
//                           //         updatedAt: updatedAt);

//                           // CategoryModel newproductModel =
//                           // ProductModel(
//                           //     categoryId: categoryDropDownController
//                           //         .selectedCategoryId
//                           //         .toString(),
//                           //     categoryName: categoryDropDownController
//                           //         .selectedCategoryName
//                           //         .toString(),
//                           //     deliveryTime:
//                           //         deliveryTimeController.text.trim(),
//                           //     fullPrice: fullPriceController.text.trim(),
//                           //     productDescription:
//                           //         productDescriptionController.text.trim(),
//                           //     productId: productModel.productId,
//                           //     productImages: productModel.productImages,
//                           //     productName: productNameController.text.trim(),
//                           //     salePrice: salePriceController.text != ''
//                           //         ? salePriceController.text.trim()
//                           //         : '',
//                           //     updatedAt: DateTime.now(),
//                           //     createdAt: productModel.createdAt,
//                           //     isSale: isSaleController.isSale.value)
//                           // await FirebaseFirestore.instance
//                           //     .collection('products')
//                           //     .doc(productModel.productId)
//                           //     .update(newproductModel.toMap());
//                         },
//                         child: NormalText(color: fontGrey, title1: 'Update'),
//                       )

//                       // CustonTextField
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
