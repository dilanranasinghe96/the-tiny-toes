import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_toes/screens/view_photo_page.dart';

import '../services/network_service.dart';
import '../services/storage_service.dart';
import 'auth/login_page.dart';

class PhotosPage extends StatelessWidget {
  final int albumId;
  final String albumName;
  final String userName;

  const PhotosPage(
      {super.key,
      required this.albumId,
      required this.albumName,
      required this.userName});

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
    final networkService = Provider.of<NetworkService>(context, listen: false);

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
      body: FutureBuilder(
        future: networkService.fetchPhotos(albumId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> photos = snapshot.data!;
            return Column(
              children: [
                Text(albumName),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewPhotoPage(
                                        title: photos[index]['title'],
                                        photoUrl: photos[index]['url'],
                                        userName: userName,
                                        albumName: albumName,
                                      )));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          photos[index]['thumbnailUrl']))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                photos[index]['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
