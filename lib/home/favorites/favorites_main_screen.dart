import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo_selector/home/widgets/common_movie_tile.dart';
import 'package:movie_demo_selector/home/widgets/sign_out_button.dart';
import 'package:movie_demo_selector/models/movie.dart';
import 'package:movie_demo_selector/models/user.dart';
import 'package:movie_demo_selector/providers/main_provider.dart';
import 'package:movie_demo_selector/providers/user_provider.dart';
import 'package:movie_demo_selector/services/api_services.dart';
import 'package:provider/provider.dart';

class FavoritesMainScreen extends StatefulWidget {
  const FavoritesMainScreen({super.key});

  @override
  State<FavoritesMainScreen> createState() => _FavoritesMainScreenState();
}

class _FavoritesMainScreenState extends State<FavoritesMainScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(''), toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Favorite Movies',
                  style: theme.textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                LogOutButton(),
              ],
            ),
            Text(
              'Here you can search for your favorite movies.',
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<AppProvider>(
                builder: (context, appProvider, _) {
                  List<Movie>? myFavs = appProvider.getFavorites();
                  return ListView.builder(
                    itemCount: myFavs?.length,
                    itemBuilder: (context, index) {
                      final movie = myFavs?[index];
                      return CommonMovieTile(movie: movie as Movie);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
