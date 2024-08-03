import 'package:flutter/material.dart';
import 'package:kmart_admin/conts/consts.dart';

class NormalText extends StatelessWidget {
  final Color color;
  final String title1;
  final double? fontsize;
  final String? fontFamily;

  const NormalText(
      {super.key,
      required this.color,
      required this.title1,
      this.fontsize,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      title1,
      style:
          TextStyle(fontFamily: fontFamily, fontSize: fontsize, color: color),
    );
  }
}
