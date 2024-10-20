import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/network_service.dart';
import 'photos_page.dart';

class AlbumsPage extends StatelessWidget {
  final int userId;

  const AlbumsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final networkService = Provider.of<NetworkService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: FutureBuilder(
        future: networkService.fetchAlbums(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(albums[index]['title']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotosPage(albumId: albums[index]['id']),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
