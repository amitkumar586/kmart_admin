import 'package:uuid/uuid.dart';

class GeneratesIds {
  String generateProductId() {
    String formatedProductId;
    String uuId = const Uuid().v4();
    // customize Id
    formatedProductId = "kmart${uuId.substring(0, 5)}";
    return formatedProductId;
  }

  String generateCategoryId() {
    String formatedCategoryId;
    String uuId = const Uuid().v4();
    // customize Id
    formatedCategoryId = "kmart${uuId.substring(0, 5)}";
    return formatedCategoryId;
  }
}
