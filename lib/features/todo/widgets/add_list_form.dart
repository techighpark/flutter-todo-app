import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/constants/tech_icons.dart';
import 'package:techigh_todo/features/todo/widgets/list_item_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddListForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function onTitleChanged;
  final Function onColorTap;
  final Function onIconTap;

  const AddListForm(
      {Key? key,
      required this.formData,
      required this.onTitleChanged,
      required this.onColorTap,
      required this.onIconTap})
      : super(key: key);

  @override
  State<AddListForm> createState() => _AddListFormState();
}

class _AddListFormState extends State<AddListForm> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
            ListItemContainerWidget(
              horizontalPadding: 0,
              verticalPadding: Sizes.size16,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: TechColors.allColors[widget.formData['color']],
                    ),
                    child: Icon(
                      TechIcons.allIcons[widget.formData['icon']],
                      size: Sizes.size56,
                    ),
                  ),
                  Gaps.v20,
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: CupertinoTextField(
                      controller: _textController,
                      onChanged: (value) => widget.onTitleChanged(value),
                      // onChanged: _onChanged,
                      // onTapOutside: _onTapOutside,
                      // onEditingComplete: _onEditingComplete,
                      textInputAction: TextInputAction.done,
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
            ListItemContainerWidget(
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
            ListItemContainerWidget(
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
                  for (final color in TechColors.allColors.keys)
                    GestureDetector(
                      onTap: () => widget.onColorTap(color),
                      child: Container(
                        decoration: BoxDecoration(
                          color: TechColors.allColors[color],
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Gaps.v20,
            // ItemContainerWidget(
            //   verticalPadding: Sizes.size20,
            //   horizontalPadding: Sizes.size20,
            //   child: GridView.count(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     crossAxisCount: 6,
            //     mainAxisSpacing: Sizes.size16,
            //     crossAxisSpacing: Sizes.size16,
            //     padding: EdgeInsets.zero,
            //     children: [
            //       for (final color in Colors.accents)
            //         GestureDetector(
            //           onTap: () => _onColorTap(color),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: color,
            //               shape: BoxShape.circle,
            //             ),
            //           ),
            //         )
            //     ],
            //   ),
            // ),
            // Gaps.v20,
            ListItemContainerWidget(
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
                  for (final icon in TechIcons.allIcons.keys)
                    GestureDetector(
                      onTap: () => widget.onIconTap(icon),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          TechIcons.allIcons[icon],
                        ),
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
