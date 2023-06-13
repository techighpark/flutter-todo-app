import 'package:flutter/material.dart';

class TechighMatrixView extends StatefulWidget {
  static String routeName = 'matrix';
  static String routeUrl = '/matrix';
  const TechighMatrixView({super.key});

  @override
  State<TechighMatrixView> createState() => _TechighMatrixViewState();
}

class _TechighMatrixViewState extends State<TechighMatrixView> {
  double x = 0;
  double y = 0;
  double z = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
            ..rotateX(x)
            ..rotateY(y),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              y = y - details.delta.dx / 100;
              x = x + details.delta.dy / 100;
              setState(() {});
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
