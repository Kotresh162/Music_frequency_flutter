import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../domain/entities/decode_message.dart';
import '../controllers/audio_decode_controller.dart';

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

  final decodeUsecase = DecodeAudioMessageImpl({
    440: "A", 350: "B", 260: "C", 474: "D", 492: "E",
    401: "F", 584: "G", 553: "H", 582: "I", 525: "J",
    501: "K", 532: "L", 594: "M", 599: "N", 528: "O",
    539: "P", 675: "Q", 683: "R", 698: "S", 631: "T",
    628: "U", 611: "V", 622: "W", 677: "X", 688: "Y",
    693: "Z", 418: " "
  });

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

      // ✅ Correct way: use setAudioSource with FileAudioSource
      await _player.setAudioSource(
        AudioSource.file(filePath!),
      );

      setState(() {});
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

  Widget _buildGraph() {
    if (_frequencies.isEmpty) {
      return const Text("No frequency data yet.");
    }

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: _frequencies.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
              isCurved: true,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            )
          ],
        ),
      ),
    );
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
            _buildGraph(),
            const SizedBox(height: 20),
            Text(
              "Decoded Message: $message",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
