import 'package:flutter/material.dart';
import 'package:movie_demo_selector/auth/login.dart';
import 'package:movie_demo_selector/auth/onboarding_main_screen.dart';
import 'package:movie_demo_selector/auth/splashscreen.dart';
import 'package:movie_demo_selector/auth/user_name_register.dart';
import 'package:movie_demo_selector/home/home.dart';
import 'package:movie_demo_selector/home/widgets/movie_detail.dart';
import 'package:movie_demo_selector/models/movie.dart';
import 'package:movie_demo_selector/providers/main_provider.dart';
import 'package:movie_demo_selector/providers/user_provider.dart';
import 'package:movie_demo_selector/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a purple toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      title: 'Movie Player',
      theme: lightMovieTheme,
      darkTheme: darkMovieTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/movie-detail') {
          final movie = settings.arguments;
          return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie as Movie),
          );
        }
        // MovieDetailScreen
      },
      routes: {
        '/': (context) => const Splashscreen(),
        '/onboarding': (context) => const OnboardingMainScreen(),
        '/login': (context) => const LoginMainScreen(),
        '/user-register': (context) => const UserNameRegister(),
        '/home': (context) => const HomeScreenPage(),
      },
    );
  }
}
