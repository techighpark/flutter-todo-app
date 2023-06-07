import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/constants/tech_icons.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  // final bool bottomBorder;
  // final bool topBorder;
  final ListModel item;

  const ListItemWidget({
    Key? key,
    // required this.bottomBorder,
    // required this.topBorder,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(topBorder ? 16 : 0),
            // topRight: Radius.circular(topBorder ? 16 : 0),
            // bottomLeft: Radius.circular(bottomBorder ? 16 : 0),
            // bottomRight: Radius.circular(bottomBorder ? 16 : 0),
            ),
      ),
      contentPadding: const EdgeInsets.only(
        left: Sizes.size14,
        right: Sizes.size10,
        top: Sizes.size2,
        bottom: Sizes.size2,
      ),
      // visualDensity: VisualDensity.compact,
      // tileColor: Theme.of(context).colorScheme.onInverseSurface,
      minLeadingWidth: 30,
      leading: Container(
        padding: const EdgeInsets.all(
          Sizes.size8,
        ),
        decoration: BoxDecoration(
          color: TechColors.allColors[item.color],
          shape: BoxShape.circle,
        ),
        child: Icon(
          TechIcons.allIcons[item.icon],
          color: Colors.white,
          size: Sizes.size24,
        ),
      ),
      title: Text(item.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('1'),
          Gaps.h4,
        ],
      ),
    );
  }
}
