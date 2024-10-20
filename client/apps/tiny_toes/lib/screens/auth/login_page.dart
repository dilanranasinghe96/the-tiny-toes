import 'package:flutter/material.dart';
import 'package:tiny_toes/custom-widgets/auth_background.dart';

import '../../custom-widgets/custom_button.dart';
import '../../custom-widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: AuthBackground(
        size: size,
        content: ListView(
          children: [
            SizedBox(height: size.height * 0.08),
            CustomTextField(
              isPassword: false,
              label: 'Email',
              controller: emailController,
              prefix: Icons.email_outlined,
            ),
            CustomTextField(
              label: "Password",
              controller: passwordController,
              prefix: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              size: size,
              ontap: () {},
              text: "Log In",
              buttonColor: Colors.grey.shade900,
              textColor: Colors.white,
            ),
          ],
        ),
      )),
    );
  }
}
