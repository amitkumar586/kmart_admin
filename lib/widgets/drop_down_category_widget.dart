import 'package:get/get.dart';
import 'package:kmart_admin/controllers/category_dropdown_controller.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/widgets/mormat_text.dart';

class DropdownCategoryWidget extends StatefulWidget {
  const DropdownCategoryWidget({super.key});

  @override
  State<DropdownCategoryWidget> createState() => _DropdownCategoryWidgetState();
}

class _DropdownCategoryWidgetState extends State<DropdownCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
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
                      value:
                          categoryDropDownController.selectedCategoryId?.value,
                      items:
                          categoryDropDownController.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['categoryId'],
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  category['categoryImage'][0].toString(),
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
                          color: Colors.black, title1: "Select category"),
                      isExpanded: true,
                      elevation: 10,
                      underline: const SizedBox.shrink(),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
