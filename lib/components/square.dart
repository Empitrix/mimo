import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:mimo/animation/generator.dart';
import 'package:mimo/config/public.dart';


class Square extends StatelessWidget {
	final double size;
	final String text;
	final GenerateAnimation animation;
	final Color borderColor;
	final Color baseColor;
	final Function? onTap;

	const Square({
		super.key,
		this.size = 50,
		this.text = "",
		required this.animation,
		this.onTap,
		this.borderColor = Colors.red,
		this.baseColor = Colors.red,
	});

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			width: size,
			height: size,
			child: AnimatedGradientBorder(
				animationTime: 3,
				borderSize: 2 - animation.animation.value,
				glowSize: 10 - animation.animation.value,
				gradientColors: [
					borderColor,
					Colors.transparent,
					Colors.transparent,
					Colors.transparent,
					Colors.transparent,
					borderColor,
				],
				animationProgress: null,
				borderRadius: const BorderRadius.all(Radius.circular(5)),
				child: AnimatedBuilder(
					animation: animation.animation,
					builder: (context, child){
						return Container(
							width: size,
							height: size,
							margin: EdgeInsets.all(6 - animation.animation.value),
							decoration: const BoxDecoration(
								borderRadius: BorderRadius.all(Radius.circular(5))
							),
							child: ElevatedButton(
								style: ButtonStyle(
									backgroundColor: MaterialStatePropertyAll(
										animation.controller.value == 1 ?
										Theme.of(context).colorScheme.secondaryContainer:
										baseColor
									),
									shape: MaterialStatePropertyAll(RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(5),
									))
								),
								child: Center(child: Text(text)),
								onPressed: () async {
									if(isComputerFinished){
										if(onTap != null){ onTap!(); }
										await animation.trigger();
									}
								},
							),
						);
					},
				),
			),
		);
	}
}
