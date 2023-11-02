import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class PlaySound {
	final player = AudioPlayer();

	Future<void> correct() async {
		try{
			await player.play(AssetSource('audio/correct.wav'));
		} catch(e){ debugPrint("Audio Error: $e"); }
	}

	Future<void> wrong() async {
		try{
			await player.play(AssetSource('audio/wrong.wav'));
		} catch(e){ debugPrint("Audio Error: $e"); }
	}
}