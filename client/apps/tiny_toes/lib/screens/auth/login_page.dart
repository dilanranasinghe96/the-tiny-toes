// import 'package:flutter/material.dart';
// import 'package:tiny_toes/custom-widgets/auth_background.dart';

// import '../../custom-widgets/custom_button.dart';
// import '../../custom-widgets/custom_textfield.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//           body: AuthBackground(
//         size: size,
//         content: ListView(
//           children: [
//             SizedBox(height: size.height * 0.08),
//             CustomTextField(
//               isPassword: false,
//               label: 'Email',
//               controller: emailController,
//               prefix: Icons.email_outlined,
//             ),
//             CustomTextField(
//               label: "Password",
//               controller: passwordController,
//               prefix: Icons.lock_outline,
//               isPassword: true,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             CustomButton(
//               size: size,
//               ontap: () {},
//               text: "Log In",
//               buttonColor: Colors.grey.shade900,
//               textColor: Colors.white,
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/auth_background.dart';
import '../../custom-widgets/custom_button.dart';
import '../../custom-widgets/custom_textfield.dart';
import '../../services/storage_service.dart';
import '../users_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _hardcodedUsername = 'user';
  final String _hardcodedPassword = 'password';

  void _login() async {
    final storageService = Provider.of<StorageService>(context, listen: false);
    if (_usernameController.text.trim() == _hardcodedUsername &&
        _passwordController.text.trim() == _hardcodedPassword) {
      await storageService.saveUsername(_usernameController.text);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const UsersPage()));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Incorrect username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
                label: 'Username',
                controller: _usernameController,
                prefix: Icons.person_outline,
              ),
              CustomTextField(
                label: "Password",
                controller: _passwordController,
                prefix: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              CustomButton(
                size: size,
                ontap: () {
                  _login();
                },
                text: "Log In",
                buttonColor: Colors.grey.shade900,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
