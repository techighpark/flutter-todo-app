import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/widget_navigation/widgets/buttons/stack_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TechButtonTypeListView extends StatefulWidget {
  const TechButtonTypeListView({Key? key}) : super(key: key);

  @override
  State<TechButtonTypeListView> createState() => _TechButtonTypeListViewState();
}

class _TechButtonTypeListViewState extends State<TechButtonTypeListView> {
  final ScrollController _scrollController = ScrollController();

  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Type'),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size24,
                    horizontal: Sizes.size56,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Stack Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      const StackButton(),
                      Gaps.v40,
                      const Text(
                        'Cupertino Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      CupertinoButton(
                        onPressed: _onPressed,
                        color: Colors.orange,
                        child: Column(
                          children: const [
                            Text('Default'),
                          ],
                        ),
                      ),
                      Gaps.v40,
                      const Text(
                        'Text Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      TextButton(
                        onPressed: _onPressed,
                        child: const Text('Default'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: Sizes.size24,
                          ),
                        ),
                        onPressed: _onPressed,
                        child: const Text('Style'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: Sizes.size24,
                          ),
                        ),
                        onPressed: _onPressed,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size12,
                            vertical: Sizes.size12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Text('Container'),
                        ),
                      ),
                      Gaps.v40,
                      const Text(
                        'Elevated Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: null,
                        child: const Text('Disabled'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: _onPressed,
                        child: const Text('Disabled'),
                      ),
                      Gaps.v40,
                      const Text(
                        'Outlined Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: _onPressed,
                        child: const Text('Disabled'),
                      ),
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: null,
                        child: const Text('Disabled'),
                      ),
                      Gaps.v40,
                      const Text(
                        'Floating Action Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      Gaps.v40,
                      const Text(
                        'Raw Material Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      Gaps.v40,
                      const Text(
                        'Outlined Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                      Gaps.v40,
                      const Text(
                        'Icon Button',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v4,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
