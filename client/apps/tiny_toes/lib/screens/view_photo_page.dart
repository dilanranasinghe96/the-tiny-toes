import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom-widgets/custom_text.dart';
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
        backgroundColor: Colors.lightBlueAccent,
        title: CustomText(
            text: 'Gallery',
            color: Colors.black,
            fsize: 25,
            fweight: FontWeight.bold),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _logout(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomText(
                  text: title,
                  color: Colors.black,
                  fsize: 25,
                  fweight: FontWeight.bold),
            ),
            Image.network(
              photoUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'Artist - $userName',
                    color: Colors.black,
                    fsize: 20,
                    fweight: FontWeight.w500),
                CustomText(
                    text: 'Album - $albumName',
                    color: Colors.black,
                    fsize: 20,
                    fweight: FontWeight.w500),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
