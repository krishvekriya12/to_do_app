import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/pages/home_page.dart';

final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);

void main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('mybox');
  final isDark = box.get('DARK_MODE', defaultValue: false);
  themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.yellow,
            primaryColor: Colors.yellow,
            scaffoldBackgroundColor: Colors.yellow[200],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.yellow,
            scaffoldBackgroundColor: const Color(0xFF181818),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF242424),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
