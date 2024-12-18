import 'package:flutter/material.dart';
import 'package:frontend/services/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> notes;
  final ApiService apiService = ApiService(); // Instance ApiService

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Panggil fungsi untuk mendapatkan catatan
  }

  void _fetchNotes() {
    // Memperbarui future notes
    setState(() {
      notes = apiService.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteKeun'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: notes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada catatan'));
            }

            final notesData = snapshot.data!;
            return ListView.builder(
              itemCount: notesData.length,
              itemBuilder: (context, index) {
                final note = notesData[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke ViewNoteScreen dengan noteId
                    Navigator.pushNamed(
                      context,
                      '/view-note',
                      arguments: {'noteId': note['id']},
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.note, color: Colors.purple),
                      title: Text(note['title'] ?? 'No Title'),
                      subtitle: Text(note['description'] ?? 'No Description'),
                      trailing: IconButton(
                        onPressed: () {
                          // Hapus catatan
                          _showDeleteDialog(context, note);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-note').then((_) {
            _fetchNotes(); // Memperbarui daftar catatan setelah kembali dari CreateNoteScreen
          });
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Catatan'),
          content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Tutup dialog
                try {
                  // Panggil API untuk menghapus catatan
                  await apiService.deleteNoteById(note['id']);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Catatan "${note['title']}" berhasil dihapus'),
                    ),
                  );
                  _fetchNotes(); // Refresh daftar catatan
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus catatan: $e')),
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
