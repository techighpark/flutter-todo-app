import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxTypeReminderWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  const BoxTypeReminderWidget(
      {Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  State<BoxTypeReminderWidget> createState() => _BoxTypeReminderWidgetState();
}

class _BoxTypeReminderWidgetState extends State<BoxTypeReminderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Sizes.size12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(
          Sizes.size10,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                ),
                Gaps.v6,
                Text(widget.title)
              ],
            ),
          ),
          Text(
            '0',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
          )
        ],
      ),
    );
  }
}
