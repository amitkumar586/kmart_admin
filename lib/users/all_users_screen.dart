import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/models/user_model.dart';
import '../controllers/get_all_users.dart';
import '../widgets/mormat_text.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    GetAllUserController getAllUserController = Get.put(GetAllUserController());

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Obx(
          () => NormalText(
            color: const Color(0xff000000),
            title1:
                'Users (${getAllUserController.usercollectionLength.toString()})',
            fontFamily: semibold,
            fontsize: 16,
          ),
        ),

        actions: [
          Center(
            child: NormalText(
                fontFamily: semibold,
                fontsize: 12,
                color: const Color(0xff000000),
                title1:
                    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .orderBy('createdOn', descending: true)
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
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];

                    UserModel userModel = UserModel(
                        uId: data['uId'],
                        userName: data['userName'],
                        userEmail: data['userEmail'],
                        phone: data['phone'],
                        userImg: data['userImg'],
                        userDeviceToken: data['userDeviceToken'],
                        country: data['country'],
                        userAddress: data['userAddress'],
                        street: data['street'],
                        city: data['city'],
                        isAdmin: data['isAdmin'],
                        isActive: data['isActive'],
                        createdOn: data['createdOn']);

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                          userModel.userImg,
                        )),
                        title: NormalText(
                            color: fontGrey, title1: userModel.userName),
                        subtitle: NormalText(
                          color: fontGrey,
                          title1: userModel.userEmail,
                          fontsize: 10,
                        ),
                        trailing: const Icon(Icons.edit),
                      ),
                    );
                  });
            }
            return const SizedBox();
          }),
    );
  }
}
