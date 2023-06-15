import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techigh_todo/features/dev_route/tech_route_main.dart';
import 'package:techigh_todo/features/dev_route/tech_route_sub_without.dart';

class TechRouteSubFirst extends StatelessWidget {
  static String routeUrl = '/routefirst';
  static String routeName = 'routefirst';
  const TechRouteSubFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              routeName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            CupertinoButton(
              child: const Text('pushAndRemoveUntil: false'),
              onPressed: () {
                null;
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const TechRouteSubFirst(),
                //   ),
                //   (route) {
                //     return false;
                //   },
                // );
              },
            ),
            CupertinoButton(
              child: const Text('pushReplacement'),
              onPressed: () {
                Navigator.replace(
                  context,
                  oldRoute: MaterialPageRoute(
                    builder: (context) => const TechRouteMain(),
                  ),
                  newRoute: MaterialPageRoute(
                    builder: (context) => const TechRouteSubWithout(),
                  ),
                );
              },
            ),

            /// 현재 페이지 스택을 새로운 페이지로 교체하는 데 사용
            /// 기존 페이지를 모두 제거하고 새로운 페이지로 스택을 구성
            /// 1. 로그인 > 대시보드 페이지
            /// 2. 페이지 스택 초기화
            ///   : 앱의 특정 지점에서 페이지 스택을 완전히 초기화 하고 새로운 페이지로 시작하는 경우
            ///   : 로그아웃 > 로그인 페이지
            ///   ERROR
            CupertinoButton(
              child: const Text('replace'),
              onPressed: () {
                Navigator.replace(
                  context,
                  oldRoute: MaterialPageRoute(
                    builder: (context) => const TechRouteMain(),
                  ),
                  newRoute: MaterialPageRoute(
                    builder: (context) => const TechRouteSubFirst(),
                  ),
                );
              },
            ),

            /// similar to pushAndRemoveUntil:false
            CupertinoButton(
              child: const Text('go'),
              onPressed: () {
                context.go(TechRouteSubFirst.routeUrl);
              },
            ),
            CupertinoButton(
              child: const Text('go'),
              onPressed: () {
                context.go(TechRouteSubFirst.routeUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}
