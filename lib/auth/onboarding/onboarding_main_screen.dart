import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  String _status = 'Esperando';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: '',
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/onboarding_1.png'),
                Text(
                  'The Most Popular Movies',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Discover what everyone’s watching right now — from box office hits to trending favorites, all in one place.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/onboarding_2.png'),
                Text(
                  'Search for your favorite movies.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Find exactly what you’re looking for. Search by title and instantly explore your favorite genres and stars.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/onboarding_3.png'),
                Text(
                  'Your Favorite Movies',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Build your own movie list. Save the films you love and watch them anytime you want.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
        showSkipButton: true,
        skip: const Text("Saltar"),
        next: const Text("Siguiente"),
        done: const Text("Hecho"),
        onDone: () {
          Navigator.pushNamed(context, '/login');
        },
        baseBtnStyle: TextButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
        ),
        // skipStyle: TextButton.styleFrom(primary: Colors.red),
        doneStyle: TextButton.styleFrom(foregroundColor: Colors.green),
        // nextStyle: TextButton.styleFrom(primary: Colors.blue),
      ),
    );
  }
}
