import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class TechListWheelView extends StatefulWidget {
  const TechListWheelView({Key? key}) : super(key: key);

  @override
  State<TechListWheelView> createState() => _TechListWheelViewState();
}

class _TechListWheelViewState extends State<TechListWheelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Wheel View'),
        // automaticallyImplyLeading: false,
        actions: const [
          CloseButton(),
        ],
      ),
      body: Stack(
        children: [
          const Positioned(
            child: Center(
              child: Text(
                'WTF ?',
                style: TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView(
              // overAndUnderCenterOpacity: 0.6,
              // useMagnifier: true,
              // magnification: 1.5,
              diameterRatio: 2,
              offAxisFraction: 0.3,
              itemExtent: 200,
              squeeze: 0.8,
              children: [
                for (var x in [1, 2, 3, 1, 2, 45, 6, 78, 4])
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.pink,
                            Colors.deepOrange,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade900,
                            offset: Offset(3.0, 3.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(-10.0, 3.0),
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Text('Pick me'),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
