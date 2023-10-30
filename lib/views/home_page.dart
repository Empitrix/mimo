import 'package:flutter/material.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/components/square.dart';
import 'package:mimo/database/db.dart';

class HomePage extends StatefulWidget {
	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

	final int genNum = 4;
	List<GenerateAnimation> animations = [];
	bool isLoaded = false;
	// Scores
	int highScore = 0;
	int currentScore = 0;

	Future<void> startTheGame() async {

	}

	Future<void> init() async {
		DB db = DB();
		setState(() { isLoaded = false; });
		await updateDbPath();  // update database's path
		await db.init();  // Initialize database (create table)
		initAnimations();  // Load animations
		highScore = await db.getScore();
		// await db.updateScore(69);  // Update score just in case
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
											Square(
												size: 100,
												text: "[${i + 1}, ${j + 1}]",
												animation: animations[ (i * genNum) + j ],
												borderColor: animations[ (i * genNum) + j ].borderColor,
												baseColor: animations[ (i * genNum) + j ].baseColor,
											),
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
