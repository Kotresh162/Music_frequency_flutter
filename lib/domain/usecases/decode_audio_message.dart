
import '../entities/decode_message.dart';
abstract class DecodeAudioMessage {
  Future<DecodedMessage> call(String path);
}