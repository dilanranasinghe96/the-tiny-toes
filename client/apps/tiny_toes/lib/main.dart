import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/users_page.dart';
import 'services/network_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NetworkService>(create: (_) => NetworkService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Users API Demo',
      home: UsersPage(),
    );
  }
}
