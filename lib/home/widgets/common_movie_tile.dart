import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:movie_demo_selector/models/movie.dart';

class CommonMovieTile extends StatelessWidget {
  const CommonMovieTile({super.key, required this.movie});
  final Movie movie;

  static const String _tmdbBaseImageUrl = 'https://image.tmdb.org/t/p/w300';

  String? _resolveImagePath() {
    if (movie.posterPath.isNotEmpty)
      return '$_tmdbBaseImageUrl${movie.posterPath}';

    // Prefiere backdrop; si no hay, usa poster; si no hay ninguno, null

    return null;
  }

  String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd-$mm-$yyyy';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = _resolveImagePath();
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme
                    .colorScheme
                    .surfaceVariant, // fondo por si tarda en cargar
              ),
              clipBehavior: Clip.antiAlias, // necesario para recortar contenido
              width: 120,
              height: 150,
              child: CachedNetworkImage(
                imageUrl: '$imageUrl',
                fit: BoxFit.cover, // llena y recorta como póster
                placeholder: (_, __) => Container(
                  color: theme.colorScheme.surfaceVariant,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: theme.colorScheme.surfaceVariant,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined, size: 28),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(movie.title, style: theme.textTheme.headlineSmall),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 7),
                    StarRating(
                      mainAxisAlignment: MainAxisAlignment.start,
                      rating: movie.voteAverage,
                    ),
                    SizedBox(height: 7),
                    Text('Date: ${_formatDate(movie.releaseDate)}'),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Redirige a la ruta nombrada 'movie-detail' con el Movie como argumento
                  Navigator.pushNamed(
                    context,
                    '/movie-detail',
                    arguments: movie,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      leading: SizedBox(
        width: 90, // <-- ancho fijo
        child: AspectRatio(
          aspectRatio: 2 / 3, // <-- vertical (ancho:alto)
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: (imageUrl == null || imageUrl.isEmpty)
                ? Container(
                    color: theme.colorScheme.surfaceVariant,
                    alignment: Alignment.center,
                    child: const Icon(Icons.movie, size: 32),
                  )
                : Hero(
                    tag: imageUrl,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover, // llena y recorta como póster
                      placeholder: (_, __) => Container(
                        color: theme.colorScheme.surfaceVariant,
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: theme.colorScheme.surfaceVariant,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),

      // leading: ClipRRect(
      //   borderRadius: BorderRadius.circular(8),
      //   child: SizedBox(
      //     width: 120, // ancho menor
      //     height: 180, // alto mayor
      //     child: imageUrl == null
      //         ? Container(
      //             color: theme.colorScheme.surfaceVariant,
      //             alignment: Alignment.center,
      //             child: const Icon(Icons.movie, size: 32),
      //           )
      //         : Hero(
      //             tag: imageUrl,
      //             child: CachedNetworkImage(
      //               imageUrl: imageUrl,
      //               fit: BoxFit.cover, // llena y recorta
      //               placeholder: (_, __) => Container(
      //                 color: theme.colorScheme.surfaceVariant,
      //                 alignment: Alignment.center,
      //                 child: const SizedBox(
      //                   width: 20,
      //                   height: 20,
      //                   child: CircularProgressIndicator(strokeWidth: 2),
      //                 ),
      //               ),
      //               errorWidget: (_, __, ___) => Container(
      //                 color: theme.colorScheme.surfaceVariant,
      //                 alignment: Alignment.center,
      //                 child: const Icon(Icons.broken_image_outlined, size: 28),
      //               ),
      //             ),
      //           ),
      //   ),
      // ),
      //   title: Text(movie.title, style: theme.textTheme.headlineSmall),
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       StarRating(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         rating: movie.voteAverage,
      //       ),
      //       Text('Date: ${_formatDate(movie.releaseDate)}'),
      //     ],
      //   ),
      //   trailing: const Icon(Icons.chevron_right),
      //   onTap: () {
      //     // Redirige a la ruta nombrada 'movie-detail' con el Movie como argumento
      //     Navigator.pushNamed(context, '/movie-detail', arguments: movie);
      //   },
      // );
    );
  }
}
