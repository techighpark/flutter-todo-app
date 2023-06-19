import 'dart:ui';

import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/view_models/reminders_vm.dart';
import 'package:techigh_todo/features/todo/widgets/reminder_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDetailView extends ConsumerStatefulWidget {
  final ListModel list;
  const ListDetailView(this.list, {Key? key}) : super(key: key);

  @override
  ConsumerState<ListDetailView> createState() => _ListDetailViewState();
}

class _ListDetailViewState extends ConsumerState<ListDetailView> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  bool _isAdding = false;
  int? _focusedReminderIndex;

  void _onNewReminderButtonTap(int index) {
    _isAdding = true;
    _focusedReminderIndex = index;
    setState(() {});
  }

  void _onReminderTap(int index, void Function() function) {
    _focusedReminderIndex = index;
    _isAdding = false;
    function();
    setState(() {});
  }

  void _onBodyTap(int totalCount) {
    if (_isAdding) {
      _focusedReminderIndex = null;
      _isAdding = false;
    } else if (!_isAdding && _focusedReminderIndex != null) {
      _focusedReminderIndex = null;
    } else {
      _focusedReminderIndex = totalCount + 2;
      _isAdding = true;
    }
    setState(() {});
  }

  /// when scroll over 90 of offset, show title
  void _onScroll() {
    final showTitle = _scrollController.offset > 90;
    if (showTitle != _showTitle) {
      setState(() {
        _showTitle = showTitle;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(remindersProvider(widget.list.id));

    return Scaffold(
      appBar: ListDetailAppBar(
        showTitle: _showTitle,
        widget: widget,
        context: context,
      ),
      body: GestureDetector(
        onTap: () => _onBodyTap(reminders.value!.length),
        child: Stack(
          children: [
            reminders.when(
              data: (reminders) {
                return ListView.builder(
                  /// _isAdding = false : total length + 1(title)
                  /// _isAdding = true : total length + 1 + 1(add reminder)
                  itemCount: reminders.length + (_isAdding ? 2 : 1),
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      /// title
                      return ListTitle(widget: widget);
                    } else if (reminders.length + 1 == index) {
                      /// add reminder
                      return ReminderItemWidget(
                        index: index,
                        list: widget.list,
                        isAdding: true,
                        onTap: _onReminderTap,
                        reminder: null,
                        isFocused: _focusedReminderIndex == index + 1,
                      );
                    } else {
                      /// reminder
                      return ReminderItemWidget(
                        index: index,
                        list: widget.list,
                        isAdding: false,
                        onTap: _onReminderTap,
                        reminder: reminders[index - 1],
                        isFocused: _focusedReminderIndex == index,
                      );
                    }
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (err, stack) => Text('Error: $err'),
            ),
            if ((!reminders.isLoading &&
                reminders.value!.isEmpty &&
                !_isAdding))
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
              onPressed: () =>
                  _onNewReminderButtonTap(reminders.value!.length + 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.plus_circle_fill,
                    color: TechColors.allColors[widget.list.color],
                  ),
                  Gaps.h8,
                  Text(
                    'New Reminder',
                    style: TextStyle(
                      color: TechColors.allColors[widget.list.color],
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

class ListTitle extends StatelessWidget {
  const ListTitle({
    super.key,
    required this.widget,
  });

  final ListDetailView widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        vertical: Sizes.size10,
      ),
      child: Text(
        widget.list.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: TechColors.allColors[widget.list.color],
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class ListDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).padding.top); // 예시로 높이를 56으로 설정

  const ListDetailAppBar({
    super.key,
    required bool showTitle,
    required this.widget,
    required this.context,
  }) : _showTitle = showTitle;

  final bool _showTitle;
  final ListDetailView widget;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leadingWidth: 110,
      title: AnimatedOpacity(
        opacity: _showTitle ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Text(widget.list.title),
      ),
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
    );
  }
}
