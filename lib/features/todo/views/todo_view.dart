import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/widgets/BoxTypeReminderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoView extends StatefulWidget {
  static String routeName = 'todo';
  static String routeUrl = '/todo';

  const ToDoView({Key? key}) : super(key: key);

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  void _onFloatingButtonTap() {}
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              flexibleSpace: SizedBox(
                width: double.infinity,
                child: CupertinoSearchTextField(),
              ),
              // title: CupertinoSearchTextField(),
            ),
            SliverGrid(
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.plus_circle_fill),
                  SizedBox(width: 8.0),
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
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
