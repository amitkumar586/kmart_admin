import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/charts/chart_order_model.dart';

class GetAllOrdersChart extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<ChartData> monthlyOrderData = RxList<ChartData>();

  @override
  void onInit() {
    super.onInit();
    fetchMonthlyOrders();
  }

  Future<void> fetchMonthlyOrders() async {
    CollectionReference ordersCollection = _firestore.collection('orders');

    final DateTime dateMonthAgo =
        DateTime.now().subtract(const Duration(days: 365));

    final QuerySnapshot allUserSnapshot = await ordersCollection.get();
    final Map<String, int> monthlyCount = {};

    for (QueryDocumentSnapshot userSnapshot in allUserSnapshot.docs) {
      final QuerySnapshot userOrderSnapshot = await ordersCollection
          .doc(userSnapshot.id)
          .collection('confirmOrders')
          .where('createdAt', isGreaterThanOrEqualTo: dateMonthAgo)
          .get();

      userOrderSnapshot.docs.forEach((order) {
        final Timestamp timestamp = order['createdAt'];
        final DateTime ordersDate = timestamp.toDate();
        final String monthYearKey = '${ordersDate.year}-${ordersDate.month}';
        monthlyCount[monthYearKey] = (monthlyCount[monthYearKey] ?? 0) + 1;
      });
    }
    final List<ChartData> monthlyData = monthlyCount.entries
        .map((entry) =>
            ChartData(month: entry.key, valuue: entry.value.toDouble()))
        .toList();

    if (monthlyData.isEmpty) {
      monthlyOrderData.add(ChartData(month: "Data not found", valuue: 0));
    } else {
      monthlyData.sort((a, b) => a.month.compareTo(b.month));
      monthlyOrderData.assignAll(monthlyData);
    }
  }
}
