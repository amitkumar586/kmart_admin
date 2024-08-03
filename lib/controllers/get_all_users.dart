import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetAllUserController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _usercontrollerSubscription;

  final Rx<int> usercollectionLength = 0.obs;

  @override
  void onInit() {
    super.onInit();

    _usercontrollerSubscription = _firebaseFirestore
        .collection('users')
        .where('isAdmin', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      usercollectionLength.value = snapshot.size;
    });
  }

  @override
  void onClose() {
    _usercontrollerSubscription.cancel();
    super.onClose();
  }
}
