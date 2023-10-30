import 'package:flutter/material.dart';


class Square extends StatelessWidget {
	final double size;
	final String text;
	const Square({super.key, this.size = 50, this.text = "",});

	@override
	Widget build(BuildContext context) {
		return Container(
			height: size, width: size,
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(8),
				color: Theme.of(context).colorScheme.secondaryContainer,
				border: Border.all(width: 2, color: Colors.green.withOpacity(0.8))
			),
			child: Center(child: Text(text)),
		);
	}
}
