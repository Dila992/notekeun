import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api.dart';

class ViewNoteScreen extends StatefulWidget {
  final int? noteId;

  const ViewNoteScreen({super.key, this.noteId});

  @override
  ViewNoteScreenState createState() => ViewNoteScreenState();
}

class ViewNoteScreenState extends State<ViewNoteScreen> {
  late Future<Map<String, dynamic>> noteData;
  final ApiService apiService = ApiService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false; 
  String? _currentAudioPath; 

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      noteData = apiService.getNotesById(widget.noteId!);
    } else {
      throw Exception('Note ID tidak disediakan.');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/edit-note',
                arguments: {'noteId': widget.noteId},
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: noteData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Terjadi kesalahan: ${snapshot.error}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Data catatan tidak ditemukan'));
          }

          final note = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note['title'] ?? 'Tidak ada judul',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  note['description'] ?? 'Tidak ada deskripsi',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                if (note['imagePath'] != null && note['imagePath'] != '')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gambar:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.network(
                        note['imagePath'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) => const Text('Gagal memuat gambar'),
                      ),
                    ],
                  )
                else
                  const Text('Gambar tidak tersedia'),
                if (note['audioPath'] != null && note['audioPath'] != '') ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Audio Rekaman:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _toggleAudioPlayback(context, note['audioPath']),
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Pause Audio' : 'Putar Audio'),
                  ),
                ] else
                  const Text('Audio tidak tersedia'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _toggleAudioPlayback(BuildContext context, String audioPath) async {
    try {
      if (_isPlaying && _currentAudioPath == audioPath) {
        // Jika sedang memutar audio yang sama, hentikan
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        // Jika audio baru, putar ulang
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(audioPath)); // Gunakan audio dari URL
        setState(() {
          _isPlaying = true;
          _currentAudioPath = audioPath;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memutar audio: $e')),
      );
    }
  }
}
