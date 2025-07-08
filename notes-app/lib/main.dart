import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/design/text_system.dart';
import 'package:notes_app_sqflite/page/detail_note/detail_note_page.dart';
import 'package:notes_app_sqflite/page/home/home_page.dart';
import 'package:notes_app_sqflite/page/splash__screen.dart';
import 'package:notes_app_sqflite/providers/automatic_banner_provider.dart';
import 'package:notes_app_sqflite/providers/note_providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimationBannerProvider>(
            create: (context) => AnimationBannerProvider()),
        ChangeNotifierProvider<NotesProviders>(
            create: (context) => NotesProviders())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigationKey,
        theme: ThemeData(
          textTheme: textTheme,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.white,
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.rootnamed,
        routes: {
          HomePage.routeNamed: (context) => const HomePage(),
          SplashScreen.rootnamed: (context) => const SplashScreen(),
          DetailNotePage.routeNamed: (context) => DetailNotePage(),
        },
      ),
    );
  }
}
