import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/conts/consts.dart';
import '../models/confirm_order.dart';
import '../widgets/mormat_text.dart';
import 'order_detail_screen.dart';

class SpecificOrderDetailScreen extends StatelessWidget {
  final String docId;
  final String customerName;
  const SpecificOrderDetailScreen(
      {super.key, required this.docId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: NormalText(
          color: const Color(0xff000000),
          title1: customerName,
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(docId)
              .collection('confirmOrders')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child:
                    NormalText(color: redColor, title1: "Users not fatching"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: NormalText(color: redColor, title1: "Users not found"),
                ),
              );
            }
            if (snapshot.data!.docs.isNotEmpty) {
              final data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      String orderDocId = data[index].id;

                      ConfirmOrderModel orderModel = ConfirmOrderModel(
                          categoryId: data[index]['categoryId'],
                          categoryName: data[index]['categoryName'],
                          createdAt: data[index]['createdAt'],
                          customerAddress: data[index]['customerAddress'],
                          customerDeviceToken: data[index]
                              ['customerDeviceToken'],
                          customerId: data[index]['customerId'],
                          customerName: customerName,
                          customerPhone: data[index]['customerPhone'],
                          deliveryTime: data[index]['deliveryTime'],
                          fullPrice: data[index]['fullPrice'],
                          isSale: data[index]['isSale'],
                          productDescription: data[index]['productDescription'],
                          productId: data[index]['productId'],
                          productImages: data[index]['productImages'],
                          productName: data[index]['productName'],
                          productQuantity: data[index]['productQuantity'],
                          productTotalPrice: data[index]['productTotalPrice'],
                          salePrice: data[index]['salePrice'],
                          status: data[index]['status'],
                          updatedAt: data[index]['updatedAt']);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: textfieldGrey,
                          onTap: () {
                            Get.to(() => OrderDetailScreen(
                                orderModel: orderModel,
                                docId: snapshot.data!.docs[index].id));
                          },
                          title: NormalText(
                              fontFamily: semibold,
                              color: darkFontGrey,
                              fontsize: 12,
                              title1: data[index]['customerName']),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: fontGrey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  NormalText(
                                      fontFamily: semibold,
                                      fontsize: 10,
                                      color: fontGrey,
                                      title1: DateFormat()
                                          .add_yMd()
                                          .format(DateTime.now())),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_shipping,
                                    color: fontGrey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  NormalText(
                                      fontFamily: semibold,
                                      fontsize: 10,
                                      color: redColor,
                                      title1: 'Unpaid'),
                                ],
                              )
                            ],
                          ),

                          trailing: InkWell(
                            onTap: () {
                              showBottomSheet(
                                userDocId: docId, // user id
                                orderModel: orderModel,
                                orderDocId: orderDocId,
                              );
                            },
                            child: const Icon(Icons.more_vert),
                          ),
                          // trailing: NormalText(
                          //     fontFamily: bold,
                          //     fontsize: 14.0,
                          //     color: redColor,
                          //     title1: '${data[index]['customerPhone']}'),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }

  void showBottomSheet(
      {required String userDocId,
      required ConfirmOrderModel orderModel,
      required String orderDocId}) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(userDocId)
                          .update({
                        'status': false,
                      });
                    },
                    child: NormalText(color: redColor, title1: 'Pending')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(userDocId)
                          .update({
                        'status': true,
                      });
                    },
                    child: NormalText(color: redColor, title1: 'Delivered')),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
