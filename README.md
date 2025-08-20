
# Music Detector

This project is a Flutter-based mobile application that decodes hidden secret messages embedded inside audio files. Each character of the message is encoded as a unique frequency tone. The app analyzes the audio, detects the frequencies, maps them to characters, and reconstructs the hidden text message for display.Its provides the f1 chart of the frequencies of the sound while detecting the code.


## Features
- Audio File Selection – Pick audio files directly from your device.

-Frequency Analysis – Uses FFT (Fast Fourier Transform) to detect frequency tones inside the audio.

- Message Decoding – Converts frequency patterns into readable text characters.

- Interactive UI – Clean and simple Flutter interface for uploading audio and viewing the decoded message.
- Cross-Platform Support – Works on both Android and iOS.

## Tech Stack

**Client:** Flutter

**Packages:** flutter_fft, wav,just_audio,file_picker


## Installation

clone the Project

```bash
  git clone https://github.com/Kotresh162/Music_frequency_flutter.git
```
```bash
  cd Music_frequency_flutter
```

Fluuter commands to install

```bash
  flutter pub get
```

To run the Project

```bash
  flutter run
```
## Arcitecture
![Screenshot 2025-08-20 202124.png](..%2FPictures%2FScreenshots%2FScreenshot%202025-08-20%20202124.png)


## Requirement
### configur the xml file
```bash
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

### change the build gradle file
```bash
defaultConfig {
        applicationId = "com.music.music_frequency"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

```
## Documentation

[fftea Documentation](https://pub.dev/packages/fftea)

