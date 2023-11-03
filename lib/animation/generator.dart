import 'package:flutter/material.dart';


typedef TriggerFunc = Future<void> Function({Color? border, Color? base});


class GenerateAnimation {
	final Animation<double> animation;
	final AnimationController controller;
	late double maxValue;
	late TriggerFunc trigger;
	late Color borderColor, baseColor;

	GenerateAnimation({
		required this.animation,
		required this.controller,
		required this.trigger,
		required this.baseColor, required this.borderColor,
		this.maxValue = 1
	});
}

// Generate Expand animation
GenerateAnimation generateLinearAnimation({
	required TickerProvider ticket,
	required double initialValue,
	Set<int> range = const {0, 1},
	List<int> durations = const [300, 300],

}){

	Color baseColor = Colors.green;
	Color borderColor = Colors.white;

	AnimationController ctrl = AnimationController(
		vsync: ticket,
		duration: Duration(milliseconds: durations.first),
		reverseDuration: Duration(milliseconds: durations.last),
	);
	Animation<double> anim = Tween<double>(
		begin: range.first.toDouble(),
		end: range.last.toDouble()
	).animate(ctrl);
	ctrl.value = initialValue;

	// Future<void> trigger({Color base = Colors.green, border = Colors.white}) async {
	Future<void> trigger({Color? base, Color? border}) async {
		if(base != null){baseColor = base;}
		if(border != null){borderColor = border;}
		await ctrl.reverse();
		await Future.delayed(const Duration(milliseconds: 350));
		await ctrl.forward();
	}


	return GenerateAnimation(
		animation: anim,
		controller: ctrl,
		maxValue: range.last.toDouble(),
		borderColor: borderColor,
		baseColor: baseColor,
		trigger: trigger
	);
}
