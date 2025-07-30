import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const SecretListenerApp());
}

class SecretListenerApp extends StatelessWidget {
  const SecretListenerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SecretListenerHomepage(),
    );
  }
}

class SecretListenerHomepage extends StatefulWidget {
  const SecretListenerHomepage({super.key});
  @override
  State<SecretListenerHomepage> createState() => _SecretListenerHompageState();
}

class _SecretListenerHompageState extends State<SecretListenerHomepage> {
  FilePickerResult? result;
  AudioPlayer audioPlayer = AudioPlayer();
  double playbackRate = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Listener'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/023/986/631/original/whatsapp-logo-whatsapp-logo-transparent-whatsapp-icon-transparent-free-free-png.png',
              height: 300,
            ),
            result == null
                ? const Text('scegli un vocale')
                : Text(result!.files.single.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: playAudio,
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 100,
                ),
                ElevatedButton(
                  onPressed: togglePlaybackrate,
                  child: Text('x$playbackRate'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: const Icon(Icons.audio_file),
      ),
    );
  }

  void pickFile() async {
    result = await FilePicker.platform.pickFiles();
    setState(() {});
  }

  void playAudio() {
    if (result != null && result!.files.single.path != null) {
      audioPlayer.play(DeviceFileSource(result!.files.single.path!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File path is not available on this platform.'),
        ),
      );
    }
  }

  void togglePlaybackrate() {
    playbackRate = playbackRate == 1 ? 2 : 1;
    audioPlayer.setPlaybackRate(playbackRate);
    setState(() {});
  }
}
