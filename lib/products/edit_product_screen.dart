import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/controllers/edit_product_controller.dart';
import 'package:kmart_admin/models/product_model.dart';
import '../controllers/category_dropdown_controller.dart';
import '../controllers/is_sale_controller.dart';
import '../conts/colors.dart';
import '../conts/styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/mormat_text.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel productModel;
  const EditProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    IsSaleController isSaleController = Get.put(IsSaleController());
    CategoryDropDownController categoryDropDownController =
        Get.put(CategoryDropDownController());
    TextEditingController productNameController = TextEditingController();
    TextEditingController salePriceController = TextEditingController();
    TextEditingController fullPriceController = TextEditingController();
    TextEditingController deliveryTimeController = TextEditingController();
    TextEditingController productDescriptionController =
        TextEditingController();

    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: productModel),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: NormalText(
              color: const Color(0xff000000),
              title1: productModel.productName.toString(),
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
                        DateFormat('yyyy-MM-dd-kk:mm').format(DateTime.now())),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      width: Get.width - 20,
                      height: Get.height / 4.0,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Image.network(
                                controller.images[index],
                                fit: BoxFit.cover,
                                width: Get.width / 2,
                                height: Get.height / 4,
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                child: InkWell(
                                  onTap: () async {
                                    await controller.deleteImagesFromStorage(
                                        controller.images[index].toString());
                                    await controller.deleteImagesFromFireStore(
                                        controller.images[index].toString(),
                                        productModel.productId);

                                    // picController.removeImages(index);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.close,
                                      color: redColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // show categories
                  GetBuilder<CategoryDropDownController>(
                    init: CategoryDropDownController(),
                    builder: (categoryDropDownController) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: DropdownButton<String>(
                                  value: categoryDropDownController
                                      .selectedCategoryId?.value,
                                  items: categoryDropDownController.categories
                                      .map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category['categoryId'],
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              category['categoryImage'][0]
                                                  .toString(),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          NormalText(
                                              color: redColor,
                                              title1: category['categoryName'])
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    categoryDropDownController
                                        .setSelectedCategory(selectedValue);
                                  },
                                  hint: const NormalText(
                                      color: Colors.black,
                                      title1: "Select category"),
                                  isExpanded: true,
                                  elevation: 10,
                                  underline: const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  ///////////////

                  GetBuilder<IsSaleController>(
                      init: IsSaleController(),
                      builder: (isSaleController) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(color: fontGrey, title1: "isSale"),
                                Switch(
                                  value: isSaleController.isSale.value,
                                  activeColor: redColor,
                                  onChanged: (value) {
                                    isSaleController.toggleIsSale(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          textEditingController: productNameController
                            ..text = productModel.productName,
                          labelText: "Product Name",
                          hintText: "Product Name",
                        ),

                        isSaleController.isSale.value
                            ? CustomTextField(
                                textEditingController: salePriceController
                                  ..text = productModel.salePrice,
                                labelText: "Sale Price",
                                hintText: "Sale Price",
                              )
                            : const SizedBox.shrink(),

                        CustomTextField(
                          textEditingController: fullPriceController
                            ..text = productModel.fullPrice,
                          labelText: "Full Price",
                          hintText: "Full Price",
                        ),

                        CustomTextField(
                          textEditingController: deliveryTimeController
                            ..text = productModel.deliveryTime,
                          labelText: "Delivery Time",
                          hintText: "Delivery Time",
                        ),

                        CustomTextField(
                          textEditingController: productDescriptionController
                            ..text = productModel.productDescription,
                          labelText: "Product Description",
                          hintText: "Product Description",
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            ProductModel newproductModel = ProductModel(
                                categoryId: categoryDropDownController
                                    .selectedCategoryId
                                    .toString(),
                                categoryName: categoryDropDownController
                                    .selectedCategoryName!.value
                                    .toString(),
                                deliveryTime:
                                    deliveryTimeController.text.trim(),
                                fullPrice: fullPriceController.text.trim(),
                                productDescription:
                                    productDescriptionController.text.trim(),
                                productId: productModel.productId,
                                productImages: productModel.productImages,
                                productName: productNameController.text.trim(),
                                salePrice: salePriceController.text != ''
                                    ? salePriceController.text.trim()
                                    : '',
                                updatedAt: DateTime.now(),
                                createdAt: productModel.createdAt,
                                isSale: isSaleController.isSale.value);

                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(productModel.productId)
                                .update(newproductModel.toMap());
                          },
                          child: NormalText(color: fontGrey, title1: 'Update'),
                        )

                        // CustonTextField
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
