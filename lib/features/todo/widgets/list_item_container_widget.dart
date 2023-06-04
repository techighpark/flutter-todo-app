import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:flutter/material.dart';

class ListItemContainerWidget extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double horizontalPadding;
  const ListItemContainerWidget(
      {Key? key,
      required this.child,
      required this.verticalPadding,
      required this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            Sizes.size10,
          ),
        ),
        child: child,
      ),
    );
  }
}
