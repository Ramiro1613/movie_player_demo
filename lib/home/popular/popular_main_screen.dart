import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo_selector/home/widgets/common_movie_tile.dart';
import 'package:movie_demo_selector/home/widgets/sign_out_button.dart';
import 'package:movie_demo_selector/models/movie.dart';
import 'package:movie_demo_selector/models/user.dart';
import 'package:movie_demo_selector/providers/user_provider.dart';
import 'package:movie_demo_selector/services/api_services.dart';
import 'package:provider/provider.dart';

class PopularMainScreen extends StatefulWidget {
  const PopularMainScreen({super.key});

  @override
  State<PopularMainScreen> createState() => _PopularMainScreenState();
}

class _PopularMainScreenState extends State<PopularMainScreen> {
  final List<Map<String, String>> _categories = const [
    {'label': 'Popular', 'value': 'popular'},
    {'label': 'Top Rated', 'value': 'top_rated'},
    {'label': 'Upcoming', 'value': 'upcoming'},
    {'label': 'Now Playing', 'value': 'now_playing'},
    {'label': 'Latest', 'value': 'latest'},
  ];

  late Map<String, String> _selectedCategory;

  final ScrollController _scrollController = ScrollController();

  List<Movie> _movies = [];
  bool _loading = true; // loading del primer fetch / refresh
  bool _isFetchingMore = false; // loading del scroll infinito (paginación)

  int page = 1;
  int total_pages = 1;
  int total_results = 0;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0];
    _getPopularMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 120) {
        if (!_loading && !_isFetchingMore && page < total_pages) {
          _isFetchingMore = true;
          page++;
          _getPopularMovies(append: true).whenComplete(() {
            if (mounted) _isFetchingMore = false;
          });
        }
      }
    });
  }

  Future<void> _getPopularMovies({bool append = false}) async {
    try {
      if (!append) {
        setState(() => _loading = true);
      }
      final movies = await GeneralApi.getPopularMovies(
        '${_selectedCategory['value']}',
        page,
      );

      if (movies.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There are no movies for this category.'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      } else {
        final int currentPage = movies['page'] ?? page;
        final int totalPages = movies['total_pages'] ?? total_pages;
        final int totalResults = movies['total_results'] ?? total_results;

        final List<Movie> mappedMovies = (movies['results'] as List? ?? [])
            .map((item) => Movie.fromJson(item))
            .toList();

        if (!mounted) return;
        setState(() {
          page = currentPage;
          total_pages = totalPages;
          total_results = totalResults;

          if (append) {
            _movies.addAll(mappedMovies);
          } else {
            _movies = mappedMovies;
          }
          _loading = false;
        });

        if (!append && _movies.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('We found ${_movies.length} movies.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'There was an error while fetching the movie list, please try later.',
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final User? currentUser = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserData();

    return Scaffold(
      appBar: AppBar(title: const Text(''), toolbarHeight: 0),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            pinned: false,
            floating: false,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome ${currentUser?.nombre ?? ''}',
                      style: theme.textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    LogOutButton(),
                  ],
                ),
              ),
            ),
          ),

          // Header fijo con el Dropdown (queda visible al hacer scroll)
          SliverPersistentHeader(
            pinned: true,
            delegate: _DropdownHeader(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      children: [
                        DropdownButtonFormField<Map<String, String>>(
                          value: _selectedCategory,
                          items: _categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('${e['label']}'),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val == null) return;
                            setState(() {
                              _selectedCategory = val;
                              // reset paginación
                              page = 1;
                              total_pages = 1;
                              total_results = 0;
                              _movies.clear();
                            });
                            _getPopularMovies(append: false);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Category',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Indicador de página
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Page $page of $total_pages (${total_results} results)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          if (_loading)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: CardLoading(
                    height: 80,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    margin: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                childCount: 5,
              ),
            )
          else
            // Lista de películas
            SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
                final movie = _movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 0),
                    child: CommonMovieTile(movie: movie),
                  ),
                );
              }, childCount: _movies.length),
            ),

          // Loader inferior al paginar
          if (_isFetchingMore)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

/// Delegate para el header fijo (Dropdown)
class _DropdownHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  _DropdownHeader({required this.child});

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 2 : 0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _DropdownHeader oldDelegate) => false;
}
