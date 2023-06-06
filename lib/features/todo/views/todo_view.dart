import 'dart:ui';

import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/view_models/list_vm.dart';
import 'package:dev_app_1/features/todo/views/list_items_view.dart';
import 'package:dev_app_1/features/todo/views/new_list_modal_view.dart';
import 'package:dev_app_1/features/todo/widgets/card_widget.dart';
import 'package:dev_app_1/features/todo/widgets/list_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoView extends ConsumerStatefulWidget {
  static String routeName = 'todo';
  static String routeUrl = '/todo';

  const ToDoView({Key? key}) : super(key: key);

  @override
  ConsumerState<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends ConsumerState<ToDoView> {
  // final items = List<String>.generate(20, (index) => 'Item ${index + 1}');
  void _onFloatingButtonTap() {}
  Future<void> _onAddListTap(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // builder: (context) => SegmentedControlExample()
      builder: (context) => const NewListModalView(),
    );
  }

  void _onListTap(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListItemsView(index),
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
                (context, index) => const CardWidget(
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
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: Sizes.size16,
          //   ),
          //   sliver: SliverFixedExtentList(
          //     itemExtent: 60,
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         final items = ref.watch(listProvider);
          //         return GestureDetector(
          //           onTap: () => _onListTap(index),
          //           child: ListItemWidget(
          //             index: index,
          //             bottomBorder: index == items.length - 1,
          //             item: items.elementAt(index),
          //           ),
          //         );
          //       },
          //       childCount: ref.watch(listProvider).length,
          //     ),
          //   ),
          // ),
        ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
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
                  padding: EdgeInsets.zero,
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
