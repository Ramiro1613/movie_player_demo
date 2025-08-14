import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_demo_selector/providers/main_provider.dart';
import 'package:movie_demo_selector/providers/user_provider.dart';
import 'package:movie_demo_selector/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Future<void> validarUsuario() async {
    final user = await UserLoginService().getUsuario();
    final movies = await UserLoginService().getMovies();
    if (user != null) {
      Provider.of<UserProvider>(context, listen: false).setUserData(user);
      Provider.of<AppProvider>(context, listen: false).setSetFavorites(movies);
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      });
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/onboarding',
          (route) => false,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      validarUsuario();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Lottie.asset('assets/movie.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
