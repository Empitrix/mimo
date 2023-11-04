import 'package:flutter/material.dart';
import 'package:mimo/views/home_page.dart';

void main() {
	runApp(const MimoApp());
}

class MimoApp extends StatelessWidget {
	const MimoApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: "MIMO",
			themeMode: ThemeMode.dark,
			darkTheme: ThemeData(
				useMaterial3: true,
				fontFamily: "Orbitron",
				colorScheme: ColorScheme.fromSeed(
					seedColor: Colors.indigo,
					brightness: Brightness.dark
				)
			),
			home: const HomePage(),
		);
	}
}
