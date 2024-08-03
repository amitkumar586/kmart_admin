import 'package:get/get.dart';

import '../conts/consts.dart';
import 'mormat_text.dart';

class DashboardButton extends StatelessWidget {
  final String? imageUrl;
  final String? title1, title2;
  final double? iconHeight, iconWidht;

  const DashboardButton({
    super.key,
    this.imageUrl,
    this.title1,
    this.title2,
    this.iconHeight,
    this.iconWidht,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: Get.width * 0.42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: redColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalText(
                color: const Color(0xff000000),
                title1: title1!,
                fontFamily: semibold,
                fontsize: 12,
              ),
              NormalText(
                color: const Color(0xff000000),
                title1: title2!,
                fontFamily: semibold,
                fontsize: 12,
              ),
            ],
          ),
          Image.asset(
            imageUrl!,
            width: 20,
            height: 20,
          )
        ],
      ),
    );
  }
}
