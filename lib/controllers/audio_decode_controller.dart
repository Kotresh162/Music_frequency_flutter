import 'dart:io';
import 'dart:math';
import 'package:fftea/fftea.dart';
import 'package:wav/wav.dart';
import '../../domain/usecases/decode_audio_message.dart';
import '../domain/entities/decode_message.dart';

class DecodeAudioMessageImpl implements DecodeAudioMessage {
  final Map<int, String> freqToChar;

  DecodeAudioMessageImpl(this.freqToChar);

  @override
  Future<DecodedMessage> call(String path) async {
    final wavFile = File(path).readAsBytesSync();
    final wav = Wav.read(wavFile);

    List<double> samples = wav.channels[0].map((e) => e.toDouble()).toList();

    int chunkSize = (wav.samplesPerSecond * 0.5).round();
    String decoded = "";
    List<double> detectedFrequencies = [];  // collect freqs

    for (int i = 0; i < samples.length; i += chunkSize) {
      int end = min(i + chunkSize, samples.length);
      var chunk = samples.sublist(i, end);

      int fftSize = 1 << (log(chunk.length) ~/ ln2 + 1);
      var fft = FFT(fftSize);

      List<double> padded = List<double>.filled(fftSize, 0);
      for (int k = 0; k < chunk.length; k++) {
        padded[k] = chunk[k];
      }

      var spectrum = fft.realFft(padded);

      double maxMag = 0;
      int maxIndex = 0;
      for (int j = 0; j < spectrum.length ~/ 2; j++) {
        final re = spectrum[j].x; // real
        final im = spectrum[j].y; // imag
        double mag = sqrt(re * re + im * im);
        if (mag > maxMag) {
          maxMag = mag;
          maxIndex = j;
        }
      }

      double freq = maxIndex * wav.samplesPerSecond / fftSize;
      detectedFrequencies.add(freq); // save freq

      int nearestFreq = freqToChar.keys.reduce(
            (a, b) => (freq - a).abs() < (freq - b).abs() ? a : b,
      );

      decoded += freqToChar[nearestFreq] ?? "";
    }

    return DecodedMessage(decoded, detectedFrequencies);
  }
}
