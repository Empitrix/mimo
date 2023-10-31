import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/config/public.dart';


int randInt(int min, max){
	// max = max + 1;
	return min + Random().nextInt(max - min);
}

typedef FinishFunc = Future<bool> Function(List<int>);


Future<List<int>> pickSome(List<GenerateAnimation> input) async {
	List<int> picked = [];
	for(int i = 0; i < level; i++){
		int index = randInt(0, input.length);

		// print("Index: $index");

		GenerateAnimation selected = input[index];
		selected.borderColor = Colors.pink;
		selected.baseColor = Colors.blue;
		// await Future.delayed(const Duration(milliseconds: 100));
		await selected.trigger();

		picked.add(index);

		// for(int r = 0; r < repetition; r++){
		//
		// }
	}
	return picked;
}

class GameEngine {
	Future<void> generate(List<GenerateAnimation> animations, FinishFunc onFinished) async {

		while(gameIsRunning){
			// debugPrint('Lvl: $level');

			bool status = await onFinished(await pickSome(animations));

			if(status){
				level ++;
			} else {
				level = 0;
			}

		}

	}
}