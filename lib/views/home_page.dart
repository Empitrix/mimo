import 'package:flutter/material.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/components/square.dart';
import 'package:mimo/config/public.dart';
import 'package:mimo/database/db.dart';
import 'package:mimo/utils/engine.dart';

class HomePage extends StatefulWidget {
	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

	final int genNum = 3;
	List<GenerateAnimation> animations = [];
	bool isLoaded = false;
	// Scores
	int highScore = 0;
	int currentScore = 0;
	List<int> selectedSquares = [];

	bool checkInputs(List<int> a, List<int> b){
		for(int c = 0; c < a.length; c++){
			if(a[c] != b[c]){
				return false;
			}
		}
		return true;
	}

	Future<List<int>> waitToCollect(List<int> input) async {
		// debugPrint("[START TO LISTEN]");
		while(true){
			if(selectedSquares.length == input.length){
				// debugPrint("[FINISH LISTENING]");
				break;
			}
			await Future.delayed(const Duration(milliseconds: 500));
		}
		return selectedSquares;
	}

	Future<void> startTheGame() async {
		GameEngine().generate(animations, (input) async {
			isComputerFinished = true;  // For blocking user to don't add fast
			await waitToCollect(input);
			bool result = checkInputs(selectedSquares, input);
			selectedSquares = [];
			debugPrint("[ANSWER: $result]");
			await Future.delayed(const Duration(milliseconds: 1500));

			if(result){
				// Correct
				setState(() { currentScore ++; });
				if(currentScore > highScore){
					setState(() { highScore = currentScore; });
					await DB().updateScore(currentScore);
				}
			} else {
				// Wrong (start again)
				setState(() { currentScore = 0; });
			}

			return result;
		});
	}

	Future<void> init() async {
		DB db = DB();
		setState(() { isLoaded = false; });
		await updateDbPath();  // update database's path
		await db.init();  // Initialize database (create table)
		initAnimations();  // Load animations
		highScore = await db.getScore();
		// await db.updateScore(0);  // Update score just in case

		// Game Engine
		startTheGame();

		setState(() { isLoaded = true; });
	}

	void initAnimations() {
		// Initialize animations for squares
		animations = List<GenerateAnimation>.generate(
			genNum*genNum, (i) => generateLinearAnimation(
			ticket: this,
			initialValue: 6,
			range: {0, 6},
			durations: [300]
		));
	}

	@override
	void initState() {
		init();
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return WillPopScope(
			onWillPop: () async { return false; },
			child: Scaffold(
				appBar: AppBar(
					title: const Text("MIMO"),
					actions: [
						Container(
							margin: const EdgeInsets.only(right: 20),
							child: RichText(
								text: TextSpan(
									children: [
										TextSpan(
											text: currentScore.toString(),
											style: const TextStyle(
												fontFamily: "Orbitron",
												fontSize: 30,
												fontStyle: FontStyle.italic
											),
										),
										const TextSpan(
											text: " / ",
											style: TextStyle(
												fontFamily: "Orbitron",
												fontSize: 30,
												fontStyle: FontStyle.italic
											),
										),
										TextSpan(
											text: highScore.toString(),
											style: const TextStyle(
												fontFamily: "Josef",
												fontSize: 20,
												fontStyle: FontStyle.italic
											),
										),
									]
								),
							),
						)
					],
				),
				body: isLoaded ? Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: [
							for(int i = 0; i < genNum; i++) Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									for(int j = 0; j < genNum; j++) Column(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										children: [
											Builder(
												builder: (context){
													int index = (i * genNum) + j;
													return Square(
														size: 100,
														text: "[${i + 1}, ${j + 1}]",
														animation: animations[index],
														borderColor: animations[index].borderColor,
														baseColor: animations[index].baseColor,
														onTap: (){
															if(selectedSquares.length != level){
																selectedSquares.add(index);
															}
														},
													);
												},
											)
										],
									)
								],
							)
						],
					)
				) : const Center(child: CircularProgressIndicator())
			),
		);
	}
}
