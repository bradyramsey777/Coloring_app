import 'package:flutter/foundation.dart';

/// [AudioManager] is a class that manages the audio of the application
class AudioManager {
  /// [playSound] plays a sound given its name
  ///
  /// Args:
  ///   soundName (String): The name of the sound to be played
  void playSound(String soundName) {
    if (kDebugMode) { // Check if it's in debug mode
      print('Playing sound: $soundName');
    }
  }
}