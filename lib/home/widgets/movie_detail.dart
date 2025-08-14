import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:movie_demo_selector/home/widgets/is_favorite_widget.dart';
import 'package:movie_demo_selector/models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  static const String _tmdbBaseImageUrl = 'https://image.tmdb.org/t/p/w300';
  String? _resolvePosterURL() {
    if (widget.movie.posterPath.isNotEmpty)
      return '$_tmdbBaseImageUrl${widget.movie.posterPath}';
    return null;
  }

  String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd-$mm-$yyyy';
  }

  String? _resolveBackdropURL() {
    if (widget.movie.backdropPath.isNotEmpty)
      return '$_tmdbBaseImageUrl${widget.movie.backdropPath}';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrlPoster = _resolvePosterURL();
    final imageUrlBackdrop = _resolveBackdropURL();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: CircleAvatar(
          minRadius: 12,
          maxRadius: 12,
          backgroundColor: Colors.black,
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.chevron_left_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .43,
                child: CachedNetworkImage(
                  imageUrl: '$imageUrlBackdrop',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 60),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme
                              .colorScheme
                              .surfaceVariant, // fondo por si tarda en cargar
                        ),
                        height: MediaQuery.of(context).size.height * .25,
                        width: MediaQuery.of(context).size.width * .35,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: '$imageUrlPoster',
                            fit: BoxFit.cover, // llena y recorta como póster
                            placeholder: (_, __) => Container(
                              color: theme.colorScheme.surfaceVariant,
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
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
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.originalTitle,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 10),
                  StarRating(
                    mainAxisAlignment: MainAxisAlignment.start,
                    rating: widget.movie.voteAverage,
                  ),
                  SizedBox(height: 10),
                  Text('Date: ${_formatDate(widget.movie.releaseDate)}'),
                  SizedBox(height: 10),
                  Text(widget.movie.overview, style: theme.textTheme.bodyLarge),
                  SizedBox(height: 30),
                  IsMovieFavorite(movie: widget.movie),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
