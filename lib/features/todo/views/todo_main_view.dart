import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/view_models/lists_vm.dart';
import 'package:techigh_todo/features/todo/views/list_detail_view.dart';
import 'package:techigh_todo/features/todo/views/add_list_view.dart';
import 'package:techigh_todo/features/todo/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/widgets/list_item.dart';

class ToDoMainView extends ConsumerStatefulWidget {
  static String routeName = 'todo';
  static String routeUrl = '/todo';

  const ToDoMainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ToDoMainView> createState() => _ToDoViewState();
}

class _ToDoViewState extends ConsumerState<ToDoMainView> {
  // final items = List<String>.generate(20, (index) => 'Item ${index + 1}');
  late final ScrollController _scrollController;
  double _appBarHeight = 200.0; // 초기 앱바 높이

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      if (_scrollController.offset > 50.0) {
        // 스크롤이 100.0 이상 되면 앱바 높이를 100.0으로 변경
        _appBarHeight = 50.0;
      } else {
        _appBarHeight = 70.0;
      }
    });
  }

  void _onFloatingButtonTap() {}
  Future<void> _onAddListTap(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // builder: (context) => SegmentedControlExample()
      builder: (context) => const AddListView(),
    );
  }

  void _onListTap(ListModel list) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListDetailView(list),
      ),
    );
  }

  /// delete list using slide action
  Future<void> _onDeleteSlideAction(ListModel item) async {
    log('_onDeleteSlideAction', name: 'todo_main_view');
    // final providerRead = ref.read(listsProvider);
    // //AsyncData<List<ListModel>>(value: [Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel'])
    // final providerReadBackValue = ref.read(listsProvider).value;
    // //[Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel']
    // final providerReadNotifierBackState =
    //     ref.read(listsProvider.notifier).state;
    // //AsyncData<List<ListModel>>(value: [Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel'])
    // final providerReadNotifier = ref.read(listsProvider.notifier);
    // //Instance of 'ListsViewModel'
    //
    // final providerWatch = ref.watch(listsProvider);
    // //AsyncData<List<ListModel>>(value: [Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel'])
    // final providerWatchBackValue = ref.watch(listsProvider).value;
    // //[Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel']
    // final providerWatchNotifierBackState =
    //     ref.watch(listsProvider.notifier).state;
    // //AsyncData<List<ListModel>>(value: [Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel'])
    // final providerWatchNotifier = ref.watch(listsProvider.notifier);
    // //Instance of 'ListsViewModel'
    //
    // print(providerRead);
    // print(providerReadBackValue);
    // print(providerReadNotifier);
    // print(providerReadNotifierBackState);
    // print(providerWatch);
    // print(providerWatchBackValue);
    // print(providerWatchNotifier);
    // print(providerWatchNotifierBackState);

    await ref.read(listsProvider.notifier).deleteList(item.id);
    log('done');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverAppBar(
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
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //       vertical: Sizes.size10,
          //       horizontal: Sizes.size16,
          //     ),
          //     child: Container(
          //       clipBehavior: Clip.hardEdge,
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.onInverseSurface,
          //         borderRadius: BorderRadius.circular(16),
          //       ),
          //       child: items.when(
          //         data: (data) => ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: items.value?.length,
          //
          //           /// TODO : Slidable - closeOnScroll 안먹음
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemBuilder: (BuildContext context, int index) {
          //             return _buildGestureDetector(data, index, items);
          //             // return Text('$data $index $items');
          //           },
          //         ),
          //         error: (error, stackTrace) {
          //           return Text('Error: $error');
          //         },
          //         loading: () {
          //           return CircularProgressIndicator();
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          // items.when(
          //   data: (data) => SliverFixedExtentList(
          //     delegate: SliverChildBuilderDelegate(
          //       childCount: 2,
          //       (BuildContext context, int index) {
          //         return Text('data');
          //       },
          //     ),
          //     itemExtent: 50,
          //   ),
          //   error: (error, stackTrace) {
          //     return SliverToBoxAdapter(
          //       child: Text('Error: $error'),
          //     );
          //   },
          //   loading: () {
          //     return const SliverToBoxAdapter(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size16,
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: items.when(
                  /// Slidable - closeOnScroll 해결
                  data: (data) => Column(
                    children: [
                      for (var item in data)
                        _buildGestureDetectorDev(data, item)
                    ],
                    // return Text('$data $index $items');
                  ),
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                ),
              ),
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

  GestureDetector _buildGestureDetector(
      List<ListModel> data, int index, AsyncValue<List<ListModel>> items) {
    return GestureDetector(
      onTap: () => _onListTap(data[index]),
      child: Slidable(
        /// Key vs ValueKey
        ///
        /// [Key]
        /// Abstract class
        /// Construct a ValueKey<String> with the given
        /// subclasses : [UniqueKey], [ObjectKey], [GlobalKey], [LocalKey]
        ///
        /// [ValueKey]
        /// Specific subclass of [Key] class
        /// Creates a key that delegates its operator == to the given value.
        key: ValueKey(data[index]),
        groupTag: 'this is groupTag',

        closeOnScroll: true,

        /// dragStartBehavior: DragStartBehavior.down,
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const BehindMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () {
          //     print('dismissable');
          //   },
          // ),
          children: [
            SlidableAction(
              onPressed: (context) {
                print(context);
                print('startActionPane');
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.orangeAccent,
              icon: CupertinoIcons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          dismissible: const Text('dismissible'),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.orangeAccent,
              icon: CupertinoIcons.delete,
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.blue,
              icon: CupertinoIcons.delete_left,
            )
          ],
        ),
        child: ListItemWidget(
          // bottomBorder: index == items.value!.length - 1,
          // topBorder: index == 0,
          item: data[index],
        ),
      ),
    );
  }

  Widget _buildGestureDetectorDev(List<ListModel> data, ListModel item) {
    return GestureDetector(
      onTap: () => _onListTap(item),
      child: Slidable(
        /// Key vs ValueKey
        ///
        /// [Key]
        /// Abstract class
        /// Construct a ValueKey<String> with the given
        /// subclasses : [UniqueKey], [ObjectKey], [GlobalKey], [LocalKey]
        ///
        /// [ValueKey]
        /// Specific subclass of [Key] class
        /// Creates a key that delegates its operator== to the given value.
        key: ValueKey(item),
        groupTag: 'this is groupTag',

        closeOnScroll: true,

        /// dragStartBehavior: DragStartBehavior.down,
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const BehindMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () {
          //     print('dismissable');
          //   },
          // ),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.orangeAccent,
              icon: CupertinoIcons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const BehindMotion(),
          // dismissible: const Text('dismissible'),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey.shade800,
              foregroundColor: Colors.white,
              icon: CupertinoIcons.info_circle_fill,
            ),
            SlidableAction(
              onPressed: (context) => _onDeleteSlideAction(item),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: CupertinoIcons.delete_solid,
            ),
          ],
        ),
        child: ListItemWidget(
          item: item,
        ),
      ),
    );
  }
}
