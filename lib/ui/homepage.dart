import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import '../../domain/entities/decode_message.dart';
import '../controllers/audio_decode_controller.dart';
import '../secrete.dart';
import 'graph.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _player;
  String? filePath;
  String message = "";
  List<double> _frequencies = [];

  final decodeUsecase = DecodeAudioMessageImpl(freqToChar);

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null && result.files.single.path != null) {
      filePath = result.files.single.path!;

      try {
        await _player.setFilePath(filePath!);
        setState(() {}); // update UI
      } catch (e) {
        debugPrint("Error loading audio: $e");
      }
    }
  }


  Future<void> _decodeAudio() async {
    if (filePath == null) return;

    DecodedMessage msg = await decodeUsecase(filePath!);
    setState(() {
      message = msg.text;
      _frequencies = msg.frequencies;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Decoder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              if (filePath != null) ...[
                Text("Selected File: ${filePath!.split('/').last}"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _player.play(),
                  child: const Text("▶ Play"),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickAudio,
                child: const Text("Upload Audio"),
              ),
              ElevatedButton(
                onPressed: _decodeAudio,
                child: const Text("Decode Audio"),
              ),
              const SizedBox(height: 20),
              buildGraph(_frequencies),
              const SizedBox(height: 20),
              Text(
                "Decoded Message:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
