import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<dynamic>> fetchAlbums(int userId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/albums?userId=$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<dynamic>> fetchPhotos(int albumId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }
}


// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NetworkService {
//   // Function to fetch users
//   Future<List<dynamic>> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }
