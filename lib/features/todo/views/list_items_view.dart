import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/todo/view_models/list_vm.dart';
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
  final List<String> items = List.generate(1, (index) => '${index + 1}');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
  Widget build(BuildContext context) {
    final item = ref.read(listProvider.notifier).state[widget.index];
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
      body: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: Text('center'),
            ),
          ),
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        for (final item in items) ...[
                          Gaps.v10,
                          Row(
                            children: [
                              Text(
                                item,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: Sizes.size28,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
