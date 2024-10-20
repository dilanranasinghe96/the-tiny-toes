import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/storage_service.dart';
import 'auth/login_page.dart';

class ViewPhotoPage extends StatelessWidget {
  final String title;
  final String photoUrl;
  final String userName;
  final String albumName;

  const ViewPhotoPage({
    super.key,
    required this.title,
    required this.photoUrl,
    required this.userName,
    required this.albumName,
  });

  void _logout(BuildContext context) async {
    final storageService = Provider.of<StorageService>(context, listen: false);
    await storageService.clearData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Image.network(
              photoUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text('Artist $userName'),
            const SizedBox(height: 20),
            Text('Album $albumName')
          ],
        ),
      ),
    );
  }
}
