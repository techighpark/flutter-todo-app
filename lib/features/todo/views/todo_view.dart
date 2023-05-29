import 'dart:ui';

import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/widgets/BoxTypeReminderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ReminderType { list, templates }

class ToDoView extends StatefulWidget {
  static String routeName = 'todo';
  static String routeUrl = '/todo';

  const ToDoView({Key? key}) : super(key: key);

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  ReminderType _selectedSegment = ReminderType.list;
  void _onFloatingButtonTap() {}
  void _closeModalTap() {
    Navigator.of(context).pop();
  }

  // void _selectSegment(value) {
  //   print(value);
  //   setState(() {});
  // }

  void _onAddListTap(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // builder: (context) => SegmentedControlExample()
      builder: (context) => StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return DefaultTabController(
            length: 2,
            child: BackdropFilter(
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
                      preferredSize: Size(double.infinity, 40.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: CupertinoSlidingSegmentedControl<ReminderType>(
                          backgroundColor: CupertinoColors.systemGrey2,
                          thumbColor:
                              Theme.of(context).colorScheme.onInverseSurface,
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
                              child: Text('Midnight'),
                            ),
                            ReminderType.templates: Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              child: Text('Midnight'),
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _onFloatingButtonTap,
            icon: const Icon(
              CupertinoIcons.ellipsis_circle,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            // floating: true,
            // flexibleSpace: SizedBox(
            //   width: double.infinity,
            //   child: CupertinoSearchTextField(),
            // ),
            title: CupertinoSearchTextField(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size16,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: 5,
                (context, index) => const BoxTypeReminderWidget(
                  title: '123',
                  icon: CupertinoIcons.cube,
                ),
              ),

              ///[GridView.builder] - reference within gridDelegate
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: Sizes.size20,
                crossAxisSpacing: Sizes.size20,
                childAspectRatio: 5 / 2,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: Sizes.size16,
              right: Sizes.size16,
              top: Sizes.size20,
              bottom: Sizes.size10,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                'My Lists',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(index == 0 ? 16 : 0),
                        topRight: Radius.circular(index == 0 ? 16 : 0),
                        bottomLeft:
                            Radius.circular(index == items.length - 1 ? 16 : 0),
                        bottomRight:
                            Radius.circular(index == items.length - 1 ? 16 : 0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: Sizes.size14,
                      right: Sizes.size10,
                      top: Sizes.size2,
                      bottom: Sizes.size2,
                    ),
                    // visualDensity: VisualDensity.compact,
                    tileColor: Theme.of(context).colorScheme.onInverseSurface,
                    minLeadingWidth: 30,
                    leading: Container(
                        padding: const EdgeInsets.all(
                          Sizes.size6,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.list_bullet,
                          color: Colors.white,
                          size: Sizes.size24,
                        )),
                    title: Text(items[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$index'),
                        Gaps.h4,
                        Icon(
                          CupertinoIcons.chevron_forward,
                          size: Sizes.size20,
                        )
                      ],
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.plus_circle_fill),
                      Gaps.h8,
                      Text('New Reminder'),
                    ],
                  ),
                  onPressed: () {},
                ),
                CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Add List'),
                    ],
                  ),
                  onPressed: () => _onAddListTap(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
