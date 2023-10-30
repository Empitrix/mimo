import 'package:flutter/material.dart';


class GenerateAnimation {
	final Animation<double> animation;
	final AnimationController controller;
	late double maxValue;
	late Function trigger;
	GenerateAnimation({
		required this.animation, required this.controller, required this.trigger, this.maxValue = 1});
}

// Generate Expand animation
GenerateAnimation generateLinearAnimation({
	required TickerProvider ticket,
	required double initialValue,
	Set<int> range = const {0, 1},
	List<int> durations = const [300, 300],

}){
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

	void trigger() async {
		await ctrl.reverse();
		await Future.delayed(const Duration(milliseconds: 350));
		await ctrl.forward();
	}

	return GenerateAnimation(
		animation: anim,
		controller: ctrl,
		maxValue: range.last.toDouble(),
		trigger: trigger
	);
}
