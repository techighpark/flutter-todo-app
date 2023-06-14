import 'dart:ui';

import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/view_models/fire_lists_vm.dart';
import 'package:techigh_todo/features/todo/view_models/fire_reminders_vm.dart';
import 'package:techigh_todo/features/todo/widgets/reminder_item_widget.dart';
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
  int _addCount = 1;
  // List<String> itemList = List.generate(10, (index) => '$index');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onNewReminderButtonTap(int index) {
    _isAdding = true;

    _focusedReminderIndex = index;
    _addCount = 2;
    setState(() {});
  }

  void _onReminderTap(int index) {
    _focusedReminderIndex = index;
    _isAdding = false;
    _addCount = 1;
    setState(() {});
  }

  void _onDismissTap(int index) {
    if (_isAdding) {
      _focusedReminderIndex = null;
      _isAdding = false;
      _addCount = 1;
    } else {
      _focusedReminderIndex = index;
      _isAdding = true;
      _addCount = 2;
    }
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
    print('list_detail_view - build');

    final reminders = ref.watch(remindersProvider(widget.list.id));
    final isLoading = ref.watch(remindersProvider(widget.list.id)).isLoading;

    print(ref.watch(remindersProvider(widget.list.id)));
    print(ref.watch(remindersProvider(widget.list.id).notifier));
    print(ref.watch(remindersProvider(widget.list.id).notifier).state);

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
      ),
      body: GestureDetector(
        onTap: () => _onDismissTap(reminders.value!.length + 1),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              reminders.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length + _addCount,
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size20,
                          ),
                          child: Text(
                            widget.list.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      TechColors.allColors[widget.list.color],
                                  fontSize: Sizes.size28,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        );
                      } else if (0 < index && index < data.length) {
                        return ReminderItemWidget(
                          list: widget.list,
                          isAdding: false,
                          index: index,
                          onTap: _onReminderTap,
                          reminder: data[index],
                          isFocused: _focusedReminderIndex == index,
                        );
                      } else {
                        return ReminderItemWidget(
                          list: widget.list,
                          isAdding: true,
                          index: index,
                          onTap: _onReminderTap,
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
              if (!reminders.isLoading && reminders.value!.isNotEmpty ||
                  !_isAdding)
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
