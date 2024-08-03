import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/controllers/category_dropdown_controller.dart';
import 'package:kmart_admin/controllers/is_sale_controller.dart';
import 'package:kmart_admin/controllers/product_pic_controller.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/models/product_model.dart';
import 'package:kmart_admin/widgets/custom_text_field.dart';
import '../services/generate_ids_service.dart';
import '../widgets/drop_down_category_widget.dart';
import '../widgets/mormat_text.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ProductPicController picController = Get.put(ProductPicController());

  CategoryDropDownController categoryDropDownController =
      Get.put(CategoryDropDownController());
  IsSaleController isSaleController = Get.put(IsSaleController());
  TextEditingController productNameController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Add Products",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NormalText(color: Colors.black, title1: "Select Image"),
                  ElevatedButton(
                    onPressed: () {
                      picController.showImagePickerDialog();
                    },
                    child:
                        const NormalText(color: Colors.black, title1: "Select"),
                  ),
                ],
              ),

              //show uploaded images
              GetBuilder<ProductPicController>(
                init: ProductPicController(),
                builder: (imgController) {
                  return imgController.selectedImages.isNotEmpty
                      ? SizedBox(
                          width: Get.width - 20,
                          height: Get.height / 3.0,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: imgController.selectedImages.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(picController
                                        .selectedImages[index].path),
                                    fit: BoxFit.cover,
                                    width: Get.width / 2,
                                    height: Get.height / 4,
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 0,
                                    child: InkWell(
                                      onTap: () {
                                        picController.removeImages(index);
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
                        )
                      : const SizedBox.shrink();
                },
              ),

              //  isSale
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

              DropdownCategoryWidget(),

              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: productNameController,
                      labelText: "Product Name",
                      hintText: " Product Name",
                    ),
                    Obx(() {
                      return isSaleController.isSale.value
                          ? CustomTextField(
                              textEditingController: salePriceController,
                              labelText: "Sale Price",
                              hintText: "Sale Price",
                            )
                          : const SizedBox.shrink();
                    }),
                    CustomTextField(
                      textEditingController: fullPriceController,
                      labelText: "Full Price",
                      hintText: "Full Price",
                    ),
                    CustomTextField(
                      textEditingController: deliveryTimeController,
                      labelText: "Delivery Time",
                      hintText: "Delivery Time",
                    ),
                    CustomTextField(
                      textEditingController: productDescriptionController,
                      labelText: "Product Description",
                      hintText: "Product Description",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await picController
                            .uploadFunction(picController.selectedImages);
                        print(picController.arrImgUrl);
                        String pId = GeneratesIds().generateProductId();
                        ProductModel productModel = ProductModel(
                            categoryId: categoryDropDownController
                                .selectedCategoryId
                                .toString(),
                            categoryName: categoryDropDownController
                                .selectedCategoryName
                                .toString(),
                            deliveryTime: deliveryTimeController.text.trim(),
                            fullPrice: fullPriceController.text.trim(),
                            productDescription:
                                productDescriptionController.text.trim(),
                            productId: pId.toString(),
                            productImages: picController.arrImgUrl,
                            productName: productNameController.text.trim(),
                            salePrice: salePriceController.text != ''
                                ? salePriceController.text.toString().trim()
                                : "",
                            updatedAt: DateTime.now(),
                            createdAt: DateTime.now(),
                            isSale: false
                            // isSaleController.isSale.value

                            );

                        FirebaseFirestore.instance
                            .collection('products')
                            .doc(pId)
                            .set(productModel.toMap());
                      },
                      child: NormalText(color: fontGrey, title1: 'Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
