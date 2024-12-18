import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchNotes() async {
    final apiUrl = 'http://localhost:8080/api/notes/search'; // Ganti dengan API URL Anda
    final query = _searchController.text;

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?q=$query'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan saat mencari catatan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghubungi server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari Catatan',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Menjalankan pencarian secara otomatis saat pengguna mengetik
                if (value.isNotEmpty) {
                  _searchNotes();
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  var note = _searchResults[index];
                  return ListTile(
                    title: Text(note['title']),
                    subtitle: Text(note['description']),
                    onTap: () {
                      // Tindakan jika catatan diklik (misalnya menuju ke detail atau edit)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
