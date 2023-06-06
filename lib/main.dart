import 'package:firebase_core/firebase_core.dart';
import 'package:techigh_todo/constants/custom_color_schemes.g.dart';
import 'package:techigh_todo/constants/text_theme.dart';
import 'package:techigh_todo/firebase_options.dart';
import 'package:techigh_todo/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  /// glue that binds the framework to the Flutter engine.
  /// initialize before calling [runApp]
  WidgetsFlutterBinding.ensureInitialized();

  /// Orientation fix
  /// 앱이 지원할 화면 방향을 설정
  /// 지정된 방향만 지원하도록 설정
  /// setPreferredOrientations = [Future]
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,

      /// DeviceOrientation.portraitDown,
      /// DeviceOrientation.landscapeLeft,
      /// DeviceOrientation.landscapeRight,
    ],
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// ThemeMode fix
  /// app 전체에서도 설정 가능하지만
  /// page 마다 설정도 가능함
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  final preferences = await SharedPreferences.getInstance();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('main.dart build');

    /// print(ref.read(listProvider));
    // prints ListViewModel
    // flutter: [Instance of 'ListModel', Instance of 'ListModel', Instance of 'ListModel']

    /// print(ref.read(listProvider.notifier));
    // prints Notifier<List<ListModel>>
    // Instance of 'ListViewModel'

    /// print(Orientation.portrait);
    /// print(Orientation.landscape);
    /// print(Orientation.values);

    return MaterialApp.router(
      title: 'First Dev App',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(routerProvider),

      /// [themeMode]에서 설정된 mode에 따라 앱 실행됨
      /// [ThemeMode.light] -> ligth만 실행됨
      /// [ThemeMode.dart] -> dark만 실행됨
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: techLightColorScheme,
        textTheme: CustomTextTheme.textTheme,
        appBarTheme: AppBarTheme(
          titleTextStyle: CustomTextTheme.textTheme.headlineSmall!.copyWith(
            color: techDarkColorScheme.onPrimary,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: techDarkColorScheme,
        textTheme: CustomTextTheme.textTheme,
        appBarTheme: AppBarTheme(
          titleTextStyle: CustomTextTheme.textTheme.headlineSmall!.copyWith(
            color: techLightColorScheme.onPrimary,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.red.withOpacity(0.2),
          // indicatorColor: Colors.orange.shade300,
          // backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
