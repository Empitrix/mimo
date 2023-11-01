import 'package:flutter/material.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/config/public.dart';
import 'dart:math';


int randInt(int min, max){
	// max = max + 1;
	return min + Random().nextInt(max - min);
}

typedef FinishFunc = Future<bool> Function(List<int>);


Future<List<int>> pickSome(List<GenerateAnimation> input) async {
	List<int> picked = [];
	for(int i = 0; i < level; i++){
		int index = randInt(0, input.length);
		GenerateAnimation selected = input[index];
		selected.borderColor = Colors.pink;
		selected.baseColor = Colors.blue;
		await selected.trigger();
		picked.add(index);
	}
	return picked;
}

class GameEngine {
	Future<void> generate(List<GenerateAnimation> animations, FinishFunc onFinished) async {

		while(gameIsRunning){

			bool status = await onFinished(await pickSome(animations));

			if(status){
				level ++;
			} else {
				level = 1;
			}

		}

	}
}