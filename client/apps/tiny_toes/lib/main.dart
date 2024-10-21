import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_toes/screens/splash_screen.dart';
import 'package:tiny_toes/services/storage_service.dart';

import 'services/network_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NetworkService>(create: (_) => NetworkService()),
        Provider<StorageService>(create: (_) => StorageService()),
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
      title: 'The Tiny Toes',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
