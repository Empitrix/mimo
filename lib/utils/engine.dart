import 'package:flutter/material.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/config/public.dart';
import 'dart:math';


int randInt(int min, max){
	// max = max + 1;
	return min + Random().nextInt(max - min);
}

typedef FinishFunc = Future<bool> Function(List<int>);


Future<List<int>> pickSome(List<GenerateAnimation> input, Function setState) async {
	List<int> picked = [];
	for(int i = 0; i < level; i++){
		int index = randInt(0, input.length);
		GenerateAnimation selected = input[index];
		setState((){
			// selected.borderColor = Colors.pink;
			// selected.baseColor = Colors.blue;
			selected.borderColor = const Color(0xffc3073f);
			selected.baseColor = const Color(0xff1B1B1F);
		});
		await selected.trigger();
		picked.add(index);
	}

	isComputerFinished = true;
	return picked;
}

class GameEngine {
	Future<void> generate(
		List<GenerateAnimation> animations, FinishFunc onFinished, Function setState) async {
		while(gameIsRunning){

			// for(int r = 0; r < repetition; r++){}  // Repetition


			isComputerFinished = false;

			bool status = await onFinished(
				await pickSome(
					List<GenerateAnimation>.from(animations.getRange(0, genNum*genNum)),
					setState));

			// Level Gen
			if(status){
				level ++;
			} else {
				level = 1;
			}

			// Grid Gen
			if(level >= 5){
				genNum = 3;
			} else {
				genNum = 2;
			}


		}  // While
	}
}
