import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techigh_todo/constants/gaps.dart';
import 'dart:math' as math;

import 'package:techigh_todo/constants/sizes.dart';

class TossCardView extends StatefulWidget {
  static String routeName = 'tossCard';
  static String routeUrl = '/tossCard';
  const TossCardView({super.key});

  @override
  State<TossCardView> createState() => _TossCardViewState();
}

class _TossCardViewState extends State<TossCardView>
    with TickerProviderStateMixin {
  int cardQuantity = 1;
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late AnimationController _bounceAnimationController;
  final Duration _animateDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();

    _initCardAnimation();
    _initButtonAnimation();
    _initBounceAnimationController();

    // _animationController.addListener(() {
    //   _startAnimate;
    // });
  }

  void _initCardAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animateDuration,
      lowerBound: 0,
      upperBound: 1.5,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward();
  }

  void _initBounceAnimationController() {
    _bounceAnimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 50,
      duration: _animateDuration,
    );
  }

  void _initButtonAnimation() {
    _buttonAnimationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.6,
      duration: _animateDuration,
    )..addListener(() {
        setState(() {});
      });
  }

  void _onCardTap() {}
  void _onButtonTap() {
    cardQuantity += 1;
    setState(() {});
    _buttonAnimationController.forward();
    _bounceAnimationController.forward();
    Future.delayed(_animateDuration, () {
      _buttonAnimationController.reverse();
      _bounceAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Gaps.v96,
              Transform(
                alignment: Alignment.topLeft,
                transform: Matrix4.identity()
                  ..rotateX(
                    _bounceAnimationController.value * (math.pi / 400),
                  )
                  ..rotateY(
                    _bounceAnimationController.value * (-math.pi / 400),
                  ),
                child: Stack(
                  children: List.generate(
                    cardQuantity,
                    (index) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(0, 3, -1.5 * index)
                          ..setEntry(0, 3, -2.0 * index)
                          ..rotateX(-0.075 * index)
                          ..rotateY(0.07 * index),
                        child: _buildCardWidget(),
                      );
                    },
                  ).reversed.toList(),
                ),
              ),
              Gaps.v96,
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _buildButton() {
    return AnimatedBuilder(
      animation: _buttonAnimationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: _buttonAnimationController.value,
          child: child,
        );
      },
      child: TextButton(
        onPressed: _onButtonTap,
        child: const Text('button'),
      ),
    );
  }

  Widget _buildCardWidget() {
    return Transform.rotate(
      angle: _animationController.value * (-math.pi / 30),
      child: Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
          // boxShadow: [
          //   const BoxShadow(
          //     offset: Offset(10, 10),
          //     color: Colors.black38,
          //     blurRadius: 20,
          //   ),
          //   BoxShadow(
          //     offset: const Offset(-10, -10),
          //     color: Colors.white.withOpacity(0.85),
          //     blurRadius: 20,
          //   )
          // ],
        ),
        child: Card(
          // color: Colors.grey.shade300,

          // shadowColor: Colors.white,
          // surfaceTintColor: Colors.indigo,
          elevation: 20,
          // color: Colors.deepOrange,
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size20,
            ),
            child: Column(
              children: [
                Text(
                  'This is Card Widget',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Gaps.v20,
                Text(
                  '1234-3456-3427-2443',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: Sizes.size16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
