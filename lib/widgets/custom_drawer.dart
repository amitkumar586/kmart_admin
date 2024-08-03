import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:kmart_admin/users/all_users_screen.dart';

import '../categories/all_category_screen.dart';
import '../conts/consts.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: redColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "data",
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: redColor,
                  child: const Text(
                    "W",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),
            const DrawrItemWidget(
              title: 'Home',
              icon: Icon(Icons.home, color: Colors.white),
            ),
            DrawrItemWidget(
              title: 'Users',
              onPresed: () {
                Get.to(const AllUsersScreen());
              },
              icon: const Icon(
                Icons.production_quantity_limits,
                color: Colors.white,
              ),
            ),
            const DrawrItemWidget(
              title: 'Orders',
              icon: Icon(Icons.shopping_bag, color: Colors.white),
            ),
            const DrawrItemWidget(
              title: 'Reviews',
              icon: Icon(Icons.shopping_bag, color: Colors.white),
            ),
            const DrawrItemWidget(
              title: 'Products',
              icon: Icon(Icons.shopping_bag, color: Colors.white),
            ),
            DrawrItemWidget(
              onPresed: () {
                Get.to(() => const AllCategoryScreen());
              },
              title: 'Category',
              icon: const Icon(Icons.shopping_bag, color: Colors.white),
            ),
            const DrawrItemWidget(
              title: 'Contacts',
              icon: Icon(Icons.help, color: Colors.white),
            ),
            GestureDetector(
              onTap: () async {
                // GoogleSignIn googleSignIn = GoogleSignIn();
                // FirebaseAuth auth = FirebaseAuth.instance;
                // await auth.signOut();
                // await googleSignIn.signOut();
                // Get.offAll(() => WelcomeScreen());
              },
              child: const DrawrItemWidget(
                title: 'Logout',
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawrItemWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final Callback? onPresed;

  const DrawrItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onPresed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onPresed,
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          leading: icon,
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
