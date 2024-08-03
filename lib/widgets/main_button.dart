import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:kmart_admin/conts/consts.dart';

class MainButton extends StatelessWidget {
  final Callback? onPressed;
  final String? title1;
  final Color? color;
  final Color? btncolor;
  final double fontSize;
  final String fontfamily;

  const MainButton(
      {super.key,
      this.onPressed,
      this.color = Colors.white,
      this.title1,
      required this.fontSize,
      this.btncolor,
      required this.fontfamily});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(12)),
      onPressed: onPressed,
      child: Text(
        title1!,
        style:
            TextStyle(color: color, fontFamily: fontfamily, fontSize: fontSize),
      ),
    );
  }
}
