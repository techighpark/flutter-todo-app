import 'dart:ui';

import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/views/item_container_widget.dart';
import 'package:dev_app_1/features/todo/views/new_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ReminderType { list, templates }

class NewListFormView extends StatefulWidget {
  const NewListFormView({Key? key}) : super(key: key);

  @override
  State<NewListFormView> createState() => _NewListFormViewState();
}

class _NewListFormViewState extends State<NewListFormView> {
  ReminderType _selectedSegment = ReminderType.list;

  void _closeModalTap() {
    Navigator.of(context).pop("This string will be passed back to the parent");
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // centerTitle: true,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: _closeModalTap,
                  child: const Text('Cancel'),
                ),
                const Text('New List'),
                CupertinoButton(
                  onPressed: _closeModalTap,
                  child: const Text('Done'),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 60.0),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  right: Sizes.size20,
                  // top: Sizes.size10,
                  bottom: Sizes.size20,
                ),
                child: CupertinoSlidingSegmentedControl<ReminderType>(
                  backgroundColor: colorScheme.onInverseSurface,
                  thumbColor: CupertinoColors.systemGrey2,
                  // This represents the currently selected segmented control.
                  groupValue: _selectedSegment,
                  // Callback that sets the selected segmented control.
                  onValueChanged: (ReminderType? value) {
                    if (value != null) {
                      setState(() {
                        _selectedSegment = value;
                      });
                    }
                  },
                  children: <ReminderType, Widget>{
                    ReminderType.list: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: const Text('New List'),
                    ),
                    ReminderType.templates: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: const Text('Templates'),
                    ),
                  },
                ),
              ),
            ),
          ),
          body: _selectedSegment == ReminderType.list
              ? NewListView()
              : Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'No Templates',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                      ),
                      children: [
                        TextSpan(
                          text: ' Upload longer videos',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
