import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../conts/colors.dart';
import '../conts/styles.dart';
import '../widgets/mormat_text.dart';
import 'specific_order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Orders",
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
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child:
                      NormalText(color: redColor, title1: "Users not fatching"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: NormalText(color: redColor, title1: "Users not found"),
                ),
              );
            }
            if (snapshot.data!.docs.isNotEmpty &&
                snapshot.data!.docs != 'null') {
              final data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: textfieldGrey,
                          onTap: () {
                            Get.to(() => SpecificOrderDetailScreen(
                                docId: data[index]['uId'],
                                customerName: data[index]['customerName']));
                          },
                          title: NormalText(
                              fontFamily: semibold,
                              color: darkFontGrey,
                              fontsize: 12,
                              title1: '8498456135'),
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
                          trailing: NormalText(
                              fontFamily: bold,
                              fontsize: 14.0,
                              color: redColor,
                              title1: '${data[index]['customerPhone']}'),
                        ),
                      ),
                    ),
                  ),
                ),
              );

              // return ListView.builder(
              //     shrinkWrap: true,
              //     physics: BouncingScrollPhysics(),
              //     itemCount: snapshot.data!.docs.length,
              //     itemBuilder: (context, index) {
              //       // final data = snapshot.data!.docs[index];

              //       // UserModel userModel = UserModel(
              //       //     uId: data['uId'],
              //       //     userName: data['userName'],
              //       //     userEmail: data['userEmail'],
              //       //     phone: data['phone'],
              //       //     userImg: data['userImg'],
              //       //     userDeviceToken: data['userDeviceToken'],
              //       //     country: data['country'],
              //       //     userAddress: data['userAddress'],
              //       //     street: data['street'],
              //       //     city: data['city'],
              //       //     isAdmin: data['isAdmin'],
              //       //     isActive: data['isActive'],
              //       //     createdOn: data['createdOn']);

              //     });
            }
            return const SizedBox();
          }),
    );
  }
}
