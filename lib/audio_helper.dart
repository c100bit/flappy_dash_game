import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late SoLoud _soLoud;
  late AudioSource _backgroundSource;
  SoundHandle? _playingBackground;

  late AudioSource _scoreSource;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;
    if (_soLoud.isInitialized) return;
    await _soLoud.init();
    _backgroundSource = await _soLoud.loadAsset('assets/audio/background.mp3');

    _scoreSource = await _soLoud.loadAsset('assets/audio/score.mp3');
  }

  Future<void> playBackgroundAudio() async {
    _playingBackground = await _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_playingBackground!, true);
  }

  Future<void> playScoreCollectSound() async {
    await _soLoud.play(_scoreSource);
  }

  void stopBackgroundAudio() {
    if (_playingBackground == null) return;
    _soLoud.fadeVolume(
      _playingBackground!,
      0,
      const Duration(milliseconds: 500),
    );
  }
}
