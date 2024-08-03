import 'package:flutter/material.dart';
import '../conts/colors.dart';
import '../conts/images.dart';
import '../conts/styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/mormat_text.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        // automaticallyImplyLeading: false,
        title: const NormalText(
          color: Color(0xff000000),
          title1: "Edit Profile",
          fontFamily: semibold,
          fontsize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const NormalText(
                fontFamily: semibold,
                fontsize: 12,
                color: Color(0xff000000),
                title1: 'Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                imgB1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: whiteColor),
              onPressed: () {},
              child: NormalText(
                color: fontGrey,
                title1: "Change",
                fontsize: 10,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: whiteColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(labelText: "Name", hintText: "Name"),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(labelText: "Password", hintText: "Password"),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
                labelText: "Confirm Password", hintText: "Confirm Password"),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
