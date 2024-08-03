import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/widgets/mormat_text.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductPicController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> arrImgUrl = <String>[].obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<void> showImagePickerDialog() async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    if (status == PermissionStatus.granted) {
      Get.defaultDialog(
        title: "Choose Image",
        middleText: "Pick an image from the camera and Gallery",
        actions: [
          ElevatedButton(
            onPressed: () {
              selectImages('Camera');
            },
            child: const NormalText(color: Colors.black, title1: 'Camera'),
          ),
          ElevatedButton(
            onPressed: () {
              selectImages('Gallery');
            },
            child: const NormalText(color: Colors.black, title1: 'Gallery'),
          )
        ],
      );
    }
    if (status == PermissionStatus.denied) {
      print("Allow Permission for further uses");
      openAppSettings();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      print("Allow Permission for further uses");
      openAppSettings();
    }
  }

  Future<void> selectImages(String type) async {
    List<XFile> imgs = [];

    if (type == 'Gallery') {
      try {
        imgs = await _imagePicker.pickMultiImage(imageQuality: 80);
        update();
      } catch (e) {
        print(e);
      }
    } else {
      final img = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      if (img != null) {
        imgs.add(img);
        update();
      }
    }

    if (imgs.isNotEmpty) {
      selectedImages.addAll(imgs);
      update();
      print(selectedImages.length);
    }
  }

  void removeImages(int index) {
    selectedImages.removeAt(index);
    update();
  }

  //
  Future<void> uploadFunction(List<XFile> images) async {
    arrImgUrl.clear();
    for (int i = 0; i < images.length; i++) {
      dynamic imageUrl = await uplaodFile(images[i]);
      arrImgUrl.add(imageUrl.toString());
    }
    update();
  }

  //
  Future<String> uplaodFile(XFile image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child("productImages")
        .child(image.name + DateTime.now().toString())
        .putFile(File(image.path));
    return await reference.ref.getDownloadURL();
  }
}
