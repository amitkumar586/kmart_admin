import 'package:get/get.dart';
import 'package:kmart_admin/conts/consts.dart';
import 'package:kmart_admin/home/main_panel.dart';
import '../widgets/main_button.dart';
import '../widgets/mormat_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: golden,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              NormalText(
                title1: 'Welcome To',
                color: whiteColor,
                fontsize: 18.0,
                fontFamily: semibold,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: whiteColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      icAppLogo,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  NormalText(
                    color: whiteColor,
                    title1: 'Kmart Seller App',
                    fontsize: 15.0,
                    fontFamily: bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: NormalText(
                  title1: 'Login to your account',
                  color: lightGrey,
                  fontsize: 12.0,
                  fontFamily: semibold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(color: whiteColor.withOpacity(0.1))],
                    color: whiteColor),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: const Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Enter email"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "* * * * * "),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: NormalText(
                            color: redColor, title1: "Forget Password ?"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: MainButton(
                        btncolor: redColor,
                        fontSize: 14.0,
                        color: whiteColor,
                        onPressed: () {
                          Get.offAll(const MainPanel());
                        },
                        title1: "Login",
                        fontfamily: semibold,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: NormalText(
                    color: lightGrey,
                    title1: "In case of any dificulty, Contact Admin"),
              ),
              const Spacer(),
              Center(
                child: NormalText(
                  color: whiteColor,
                  title1: "@kmart",
                  fontFamily: bold,
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
