import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';

class CustomBottomAppBarWidget extends StatelessWidget {
  final Future<void> Function(BuildContext) onAddListTap;
  const CustomBottomAppBarWidget({
    super.key,
    required this.onAddListTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.plus_circle_fill),
                    Gaps.h8,
                    Text('New Reminder'),
                  ],
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add List'),
                  ],
                ),
                onPressed: () => onAddListTap(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
