import 'package:notes_app_sqflite/main.dart';

class Navigation {
  static pushPage({required String route, Object? arguments}) {
    navigationKey.currentState!.pushNamed(route, arguments: arguments);
  }
  static pushReplace({required String route, Object? arguments}) {
    navigationKey.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static pop() => navigationKey.currentState!.pop(navigationKey);
}
