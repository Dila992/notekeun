import 'package:flutter/material.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/create_note_screen.dart';
import 'ui/screens/view_note_screen.dart';

void main() {
  runApp(const NoteKeunApp());
}

class NoteKeunApp extends StatelessWidget {
  const NoteKeunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeun',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      // Rute statis
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/create-note': (context) => const CreateNoteScreen(),
      },
      // Rute dinamis menggunakan onGenerateRoute
      onGenerateRoute: (settings) {
        if (settings.name == '/view-note') {
          final args = settings.arguments as Map<String, dynamic>?;
          final noteId = args?['noteId'];

          if (noteId != null) {
            return MaterialPageRoute(
              builder: (context) => ViewNoteScreen(noteId: noteId),
            );
          }
        }

        // Rute default jika tidak ditemukan
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan'),
            ),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
