import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://localhost:8080/api'; // URL API backend Anda

  // GET: Fetch all notes
  Future<List<dynamic>> getNotes({String? category}) async {
    try {
      final url = category != null
          ? Uri.parse('$baseUrl/notes?category=$category')
          : Uri.parse('$baseUrl/notes');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> notes = json.decode(response.body);
        return notes.map((note) {
          return {
            'id': int.tryParse(note['id'].toString()) ?? 0,
            'title': note['title'] ?? 'Untitled',
            'description': note['description'] ?? '',
            'imagePath': note['imagePath'],
            'audioPath': note['audioPath'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // GET: Fetch a single note by ID
  Future<Map<String, dynamic>> getNotesById(int noteId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/notes/$noteId'));

      if (response.statusCode == 200) {
        final note = json.decode(response.body);
        return {
          'id': int.tryParse(note['id'].toString()) ?? 0,
          'title': note['title'] ?? 'Untitled',
          'description': note['description'] ?? '',
          'imagePath': note['imagePath'],
          'audioPath': note['audioPath'],
        };
      } else if (response.statusCode == 404) {
        throw Exception('Note not found');
      } else {
        throw Exception('Failed to load note');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // DELETE: Delete a note by ID
  Future<void> deleteNoteById(int noteId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/notes/$noteId'));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Catatan berhasil dihapus');
        }
      } else {
        throw Exception(
            'Failed to delete note, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

    Future<void> createNote({
    required String title,
    required String description,
    required String category,
  }) async {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'category': category,
      'image_path': null, // Null jika tidak ada gambar
      'audio_path': null, // Null jika tidak ada audio
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/notes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        print('Catatan berhasil dibuat');
      } else {
        print('Gagal membuat catatan: ${response.body}');
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat membuat catatan: $e');
      throw Exception('Error: $e');
    }
  }
}
