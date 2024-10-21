import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom-widgets/custom_text.dart';
import '../services/network_service.dart';
import '../services/storage_service.dart';
import 'albums_page.dart';
import 'auth/login_page.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

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
        backgroundColor: Colors.lightBlueAccent,
        title: CustomText(
            text: 'Users',
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
      body: FutureBuilder(
        future: networkService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Card(
                    color: Colors.amber.shade100,
                    elevation: 5,
                    child: ListTile(
                      title: CustomText(
                          text: users[index]['name'],
                          color: Colors.black,
                          fsize: 20,
                          fweight: FontWeight.w500),
                      subtitle: CustomText(
                          text: users[index]['email'],
                          color: Colors.black,
                          fsize: 15,
                          fweight: FontWeight.w400),
                      leading: CircleAvatar(
                        child: CustomText(
                            text: users[index]['name'][0],
                            color: Colors.black,
                            fsize: 20,
                            fweight: FontWeight.w500),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlbumsPage(
                                userId: users[index]['id'],
                                username: users[index]['name']),
                          ),
                        );
                      },
                    ),
                  ),
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
