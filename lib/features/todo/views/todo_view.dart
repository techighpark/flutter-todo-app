import 'dart:ui';

import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/view_models/fire_lists_vm.dart';
import 'package:techigh_todo/features/todo/views/list_detail_view.dart';
import 'package:techigh_todo/features/todo/views/new_list_modal_view.dart';
import 'package:techigh_todo/features/todo/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/widgets/list_item_widget.dart';

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

  void _onListTap(ListModel list) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListDetailView(list),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(listsProvider);
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            sliver: items.when(
              data: (data) => SliverFixedExtentList(
                itemExtent: 60,
                delegate: SliverChildBuilderDelegate(
                  childCount: items.value!.length,
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => _onListTap(data[index]),
                      child: ListItemWidget(
                        bottomBorder: index == items.value!.length - 1,
                        topBorder: index == 0,
                        item: data[index],
                      ),
                    );
                  },
                ),
              ),
              error: (error, stackTrace) {
                return SliverToBoxAdapter(
                  child: Text('Error: $error'),
                );
              },
              loading: () {
                return const SliverToBoxAdapter(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.plus_circle_fill),
                      Gaps.h8,
                      Text('New Reminder'),
                    ],
                  ),
                  onPressed: () {},
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
