import 'package:get/get.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/home/home_screen.dart';
import 'package:kmart_admin/order/order_screen.dart';
import 'package:kmart_admin/products/products_screen.dart';
import 'package:kmart_admin/profile/profile_screen.dart';
import '../controllers/dashboard_controller.dart';

class MainPanel extends StatefulWidget {
  const MainPanel({super.key});

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());

    var navScreen = [
      const HomeScreen(),
      const AllProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            height: 20,
            width: 20,
            color: darkFontGrey,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrder,
            height: 19,
            width: 19,
            color: darkFontGrey,
          ),
          label: "Home"),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Home"),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              dashboardController.navIndex.value = index;
            },
            currentIndex: dashboardController.navIndex.value,
            unselectedItemColor: darkFontGrey,
            selectedItemColor: redColor,
            items: bottomNavbar),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navScreen.elementAt(dashboardController.navIndex.value),
            ),
          )
        ],
      ),
    );
  }
}
