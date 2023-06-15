import 'dart:developer';
import 'dart:ui';

import 'package:techigh_todo/common/utils/uuid_util.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/constants/tech_icons.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/view_models/lists_vm.dart';
import 'package:techigh_todo/features/todo/widgets/add_list_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ReminderType { list, templates }

class AddListView extends ConsumerStatefulWidget {
  const AddListView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddListView> createState() => _NewListModalViewState();
}

class _NewListModalViewState extends ConsumerState<AddListView> {
  ReminderType _selectedSegment = ReminderType.list;
  Map<String, dynamic> formData = {
    'title': null,
    'color': TechColors.allColors.keys.first,
    'icon': TechIcons.allIcons.keys.first,
  };

  /// title
  void _onTitleChanged(value) {
    if (value != null) {
      formData['title'] = value;
    }
    setState(() {});
  }

  /// select color
  void _onColorTap(value) {
    if (value != null) {
      formData['color'] = value;
    }
    setState(() {});
  }

  /// select icon
  void _onIconTap(value) {
    if (value != null) {
      formData['icon'] = value;
    }
    setState(() {});
  }

  /// close create new list modal
  void _onCancelModalTap() {
    Navigator.of(context).pop();
  }

  /// create new list
  void _onDoneTap() {
    ListModel listModel = ListModel(
      id: UuidUtil.uuidGenerator(),
      title: formData['title'],
      icon: formData['icon'],
      color: formData['color'],
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(listsProvider.notifier).addList(listModel);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
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
            title: _buildAppbarTitle(),
            bottom: _buildSegmentedControlBar(colorScheme),
          ),
          body: _selectedSegment == ReminderType.list
              ? AddListForm(
                  formData: formData,
                  onTitleChanged: _onTitleChanged,
                  onColorTap: (value) => _onColorTap(value),
                  onIconTap: (value) => _onIconTap(value),
                )
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

  Row _buildAppbarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
          onPressed: _onCancelModalTap,
          child: const Text('Cancel'),
        ),
        const Text('New List'),
        CupertinoButton(
          onPressed: formData['title'] != null ? _onDoneTap : null,
          child: const Text('Done'),
        ),
      ],
    );
  }

  PreferredSize _buildSegmentedControlBar(ColorScheme colorScheme) {
    return PreferredSize(
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
    );
  }
}
