import 'package:intl/intl.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/widgets/dashboard_button.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/mormat_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Dashboard",
          fontFamily: semibold,
          fontsize: 16,
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardButton(
                  imageUrl: icAppleLogo,
                  iconHeight: 18,
                  iconWidht: 18,
                  title1: "Products",
                  title2: '72',
                ),
                DashboardButton(
                  imageUrl: icAppleLogo,
                  iconHeight: 18,
                  iconWidht: 18,
                  title1: "Orders",
                  title2: '72',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardButton(
                  imageUrl: icAppleLogo,
                  iconHeight: 18,
                  iconWidht: 18,
                  title1: "Products",
                  title2: '72',
                ),
                DashboardButton(
                  imageUrl: icAppleLogo,
                  iconHeight: 18,
                  iconWidht: 18,
                  title1: "Orders",
                  title2: '72',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: NormalText(
                    color: fontGrey,
                    fontFamily: semibold,
                    title1: "Popular Products")),
            const SizedBox(
              height: 10,
            ),
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                3,
                (index) => ListTile(
                  onTap: () {},
                  leading: Image.asset(
                    imgRozarpay,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  title: NormalText(
                      fontFamily: semibold,
                      color: darkFontGrey,
                      fontsize: 12,
                      title1: 'Product Title'),
                  subtitle: NormalText(
                      color: fontGrey, fontsize: 12, title1: ' ${40.0}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
