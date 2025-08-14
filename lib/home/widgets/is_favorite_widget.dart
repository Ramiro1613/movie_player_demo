import 'package:flutter/material.dart';
import 'package:movie_demo_selector/models/movie.dart';
import 'package:movie_demo_selector/providers/main_provider.dart';
import 'package:movie_demo_selector/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class IsMovieFavorite extends StatefulWidget {
  const IsMovieFavorite({super.key, required this.movie});
  final Movie movie;
  @override
  State<IsMovieFavorite> createState() => _IsMovieFavoriteState();
}

class _IsMovieFavoriteState extends State<IsMovieFavorite> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        List<Movie>? myFavs = appProvider.getFavorites();
        print(myFavs);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * .4,
              child: myFavs!.contains(widget.movie)
                  ? InkWell(
                      onTap: () async {
                        myFavs.remove(widget.movie);
                        Provider.of<AppProvider>(
                          context,
                          listen: false,
                        ).setSetFavorites(myFavs);
                        await UserLoginService().saveMovies(myFavs);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.star),
                          Text('Remove from favorites'),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        myFavs.add(widget.movie);
                        Provider.of<AppProvider>(
                          context,
                          listen: false,
                        ).setSetFavorites(myFavs);
                        await UserLoginService().saveMovies(myFavs);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.star_border_outlined),
                          Text('Add to favorites'),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
