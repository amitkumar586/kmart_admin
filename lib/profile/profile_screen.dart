import 'package:get/get.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/profile/edit_prifile_screen.dart';
import '../widgets/mormat_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Settings",
          fontFamily: semibold,
          fontsize: 16,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const EditProfileScreen());
            },
            icon: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () {},
            child: const NormalText(
                fontFamily: semibold,
                fontsize: 12,
                color: Color(0xff000000),
                title1: 'Logout'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                imgB1,
              )),
              title: NormalText(color: fontGrey, title1: "Vender Name"),
              subtitle: NormalText(
                color: fontGrey,
                title1: "vander@qwerrid.con",
                fontsize: 10,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  2,
                  (index) => ListTile(
                    leading: const Icon(Icons.settings),
                    title: NormalText(color: fontGrey, title1: "Vender Name"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
