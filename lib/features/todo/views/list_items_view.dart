import 'dart:ui';

import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/features/todo/view_models/fire_list_vm.dart';
import 'package:techigh_todo/features/todo/widgets/reminder_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListItemsView extends ConsumerStatefulWidget {
  final int index;
  const ListItemsView(this.index, {Key? key}) : super(key: key);

  @override
  ConsumerState<ListItemsView> createState() => _ListItemsViewState();
}

class _ListItemsViewState extends ConsumerState<ListItemsView> {
  ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  bool _isAdding = false;
  int? _focusedReminder;
  List<String> itemList = List.generate(10, (index) => '$index');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onNewReminderTap() {
    _isAdding = true;
    _focusedReminder = 99;
    setState(() {});
  }

  void _onReminderTap(int index) {
    _focusedReminder = index;
    _isAdding = false;

    setState(() {});
  }

  void _onDismissTap() {
    _focusedReminder = null;
    _isAdding = false;

    setState(() {});
  }

  void _onScroll() {
    final showTitle = _scrollController.offset > 90;
    if (showTitle != _showTitle) {
      setState(() {
        _showTitle = showTitle;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.read(listProvider.notifier).state;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton.icon(
          icon: const Icon(
            CupertinoIcons.chevron_left,
            size: Sizes.size24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text(
            'Lists',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Text(item.title),
        ),
        leadingWidth: 100,
        actions: [
          CupertinoButton(
            child: const Icon(CupertinoIcons.share),
            onPressed: () {},
          ),
          CupertinoButton(
            child: const Icon(CupertinoIcons.ellipsis_circle),
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: _onDismissTap,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              ListView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                    ),
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: TechColors.allColors[item.color],
                            fontSize: Sizes.size28,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  // for (final item in items) ...[
                  Gaps.v6,
                  ReminderItemWidget(
                    item: item,
                    isAdding: false,
                    index: 0,
                    onTap: _onReminderTap,
                    isFocused: _focusedReminder == 0,
                  ),
                  if (_isAdding)
                    ReminderItemWidget(
                      item: item,
                      isAdding: true,
                      index: 99,
                      onTap: _onReminderTap,
                      isFocused: _focusedReminder == 99,
                    ),
                ],
                // ],
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    'No Reminders',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
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
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _onNewReminderTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.plus_circle_fill,
                    color: TechColors.allColors[item.color],
                  ),
                  Gaps.h8,
                  Text(
                    'New Reminder',
                    style: TextStyle(
                      color: TechColors.allColors[item.color],
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
