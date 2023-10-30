import 'package:flutter/material.dart';
import 'package:mimo/components/square.dart';

class HomePage extends StatefulWidget {
	const HomePage({super.key});

	@override
	State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

	final int genNum = 4;

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
							child: Text(
								"69",
								style: TextStyle(
									fontFamily: "Orbitron",
									fontSize: 30,
									fontStyle: FontStyle.italic
								),
							),
						)
					],
				),
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: [
							for(int i = 0; i < genNum; i++) Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									for(int j = 0; j < genNum; j++) Column(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										children: [
											Square(size: 100, text: "[$i, $j]",),
										],
									)
								],
							)
						],
					)
				),
			),
		);
	}
}
