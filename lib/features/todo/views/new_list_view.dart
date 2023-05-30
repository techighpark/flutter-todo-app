import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/views/item_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewListView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<Color> colors = [
    Colors.deepOrange,
    Colors.orange,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.pink,
    Colors.lightBlueAccent,
    Colors.indigo,
    Colors.deepPurple,
    Colors.brown,
    Colors.grey,
    Colors.green,
    Colors.lime,
  ];
  final List<IconData> icons = [
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
    CupertinoIcons.camera_on_rectangle,
  ];

  NewListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gaps.v20,
            ItemContainerWidget(
              horizontalPadding: 0,
              verticalPadding: Sizes.size16,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size16,
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      CupertinoIcons.list_bullet,
                      size: Sizes.size56,
                    ),
                  ),
                  Gaps.v20,
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: CupertinoTextField(
                      placeholder: 'List Name',
                      placeholderStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size20,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            ItemContainerWidget(
              horizontalPadding: Sizes.size14,
              verticalPadding: Sizes.size4,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Sizes.size10,
                      ),
                      color: Colors.deepOrange,
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_3_trianglepath,
                      color: Colors.white,
                    ),
                  ),
                  Gaps.h14,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Make into Smart List',
                        ),
                        Text(
                          'Organize using tags and other filters',
                          style: TextStyle(
                            color: colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    size: Sizes.size16,
                    color: colorScheme.outline,
                  ),
                ],
              ),
            ),
            Gaps.v20,
            ItemContainerWidget(
              verticalPadding: Sizes.size20,
              horizontalPadding: Sizes.size20,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 6,
                mainAxisSpacing: Sizes.size16,
                crossAxisSpacing: Sizes.size16,
                padding: EdgeInsets.zero,
                children: [
                  for (final color in colors)
                    Container(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )
                ],
              ),
            ),
            Gaps.v20,
            ItemContainerWidget(
              verticalPadding: Sizes.size20,
              horizontalPadding: Sizes.size20,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 6,
                mainAxisSpacing: Sizes.size16,
                crossAxisSpacing: Sizes.size16,
                padding: EdgeInsets.zero,
                children: [
                  for (final icon in icons)
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
