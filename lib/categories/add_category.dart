import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/models/categories.dart';
import '../controllers/category_image_store_controller.dart';
import '../services/generate_ids_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/mormat_text.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryPicController picController = Get.put(CategoryPicController());
    TextEditingController categoryNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Add Categories",
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
              GetBuilder<CategoryPicController>(
                init: CategoryPicController(),
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

              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: categoryNameController,
                      labelText: "Category Name",
                      hintText: "Category Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await picController
                            .uploadFunction(picController.selectedImages);
                        // print(picController.arrImgUrl);
                        String catId = GeneratesIds().generateCategoryId();

                        CategoriesModel categoriesModel = CategoriesModel(
                          categoryId: catId.toString(),
                          categoryImage: picController.arrImgUrl,
                          categoryName: categoryNameController.text.trim(),
                          updatedAt: DateTime.now(),
                          createdAt: DateTime.now(),
                        );

                        FirebaseFirestore.instance
                            .collection('categories')
                            .doc(catId)
                            .set(categoriesModel.toMap());
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
