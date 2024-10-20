import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/network_service.dart';
import '../services/storage_service.dart';
import 'auth/login_page.dart';
import 'photos_page.dart';

class AlbumsPage extends StatelessWidget {
  final int userId;
  final String username;

  const AlbumsPage({super.key, required this.userId, required this.username});
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
        title: const Text('Albums'),
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
        future: networkService.fetchAlbums(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> albums = snapshot.data!;
            return Column(
              children: [
                Text(username),
                Expanded(
                  child: ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Card(
                            elevation: 5,
                            color: Colors.amber.shade100,
                            child: ListTile(
                              title: Text(albums[index]['title']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotosPage(
                                      albumId: albums[index]['id'],
                                      albumName: albums[index]['title'], userName: username,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
