import 'package:techigh_todo/features/authentication/views/sign_in_form_view.dart';
import 'package:techigh_todo/features/authentication/views/sign_up_form_view.dart';
import 'package:techigh_todo/features/experiments/techigh_matrix.dart';
import 'package:techigh_todo/features/experiments/techigh_matrix.dart';
import 'package:techigh_todo/features/experiments/techigh_matrix.dart';
import 'package:techigh_todo/features/experiments/toss_card_view.dart';
import 'package:techigh_todo/features/experiments/toss_card_view.dart';
import 'package:techigh_todo/features/experiments/toss_card_view.dart';
import 'package:techigh_todo/features/main_navigation/views/tech_navigation_view.dart';
import 'package:techigh_todo/features/main_navigation/views/tech_material_navigation_view.dart';
import 'package:techigh_todo/features/main_navigation/views/tech_cupertino_tab_bar_view.dart';
import 'package:techigh_todo/features/onboarding/views/tech_single_child_scroll_view.dart';
import 'package:techigh_todo/features/todo/views/todo_view.dart';
import 'package:techigh_todo/features/widget_navigation/tech_widget_list_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/tossCard',
    routes: [
      GoRoute(
        path: TechighMatrixView.routeUrl,
        name: TechighMatrixView.routeName,
        builder: (context, state) => const TechighMatrixView(),
      ),
      GoRoute(
        path: ToDoView.routeUrl,
        name: ToDoView.routeName,
        builder: (context, state) => const ToDoView(),
      ),
      GoRoute(
        path: TossCardView.routeUrl,
        name: TossCardView.routeName,
        builder: (context, state) => const TossCardView(),
      ),
      GoRoute(
        path: SignInFormView.routeUrl,
        name: SignInFormView.routeName,
        builder: (context, state) => const SignInFormView(),
      ),
      GoRoute(
        path: SignUpFormView.routeUrl,
        name: SignUpFormView.routeName,
        builder: (context, state) => const SignUpFormView(),
      ),
      GoRoute(
        path: TechWidgetListNavigation.routeUrl,
        name: TechWidgetListNavigation.routeName,
        builder: (context, state) {
          return const TechWidgetListNavigation();
        },
      ),
      GoRoute(
        path: TechSingleChildScrollView.routeUrl,
        name: TechSingleChildScrollView.routeName,
        builder: (context, state) {
          final email = state.queryParams['email'] ?? 'no email';
          return TechSingleChildScrollView(email: email);
        },
      ),
      GoRoute(
        // path: "/:tab(home|discover|inbox|profile)",
        path: TechMaterialNavigationView.routeUrl,
        name: TechMaterialNavigationView.routeName,
        builder: (context, state) {
          // final tab = state.params["tab"]!;
          return const TechMaterialNavigationView();
        },
      ),
      GoRoute(
        path: TechCupertinoTabBarView.routeUrl,
        name: TechCupertinoTabBarView.routeName,
        builder: (context, state) {
          return const TechCupertinoTabBarView();
        },
      ),
      GoRoute(
        path: TechNavigationView.routeUrl,
        name: TechNavigationView.routeName,
        builder: (context, state) {
          return const TechNavigationView();
        },
      ),
    ],
  ),
);
