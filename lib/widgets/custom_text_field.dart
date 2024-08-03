import 'package:flutter/material.dart';
import 'package:kmart_admin/conts/colors.dart';
import 'package:kmart_admin/widgets/mormat_text.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? textEditingController;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: lightGrey),
          isDense: true,
          label: NormalText(
            color: textfieldGrey,
            title1: labelText!,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: textfieldGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: textfieldGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: textfieldGrey),
          ),
        ),
      ),
    );
  }
}
