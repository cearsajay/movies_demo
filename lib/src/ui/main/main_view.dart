import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_demo/src/constants.dart';
import 'package:movies_demo/src/data/repository/movie_repository.dart';
import 'package:movies_demo/src/localization/generated/l10n.dart';
import 'package:movies_demo/src/model/movie.dart';
import 'package:movies_demo/src/ui/main/main_provider.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  static const routeName = "/";

  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final movieRepository = Provider.of<MovieRepository>(context, listen: false);
        return MainProvider(movieRepository: movieRepository)..getPopularMovies();
      },
      builder: (context, child) => const _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.moviesTitle),
      ),
      body: Builder(builder: (context) {
        final bool isLoading = context.select<MainProvider, bool>((value) => value.isLoading);
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final bool hasError = context.select<MainProvider, bool>((value) => value.hasError);
        if (hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline_rounded, size: 48),
                const SizedBox(height: 8),
                Text(appLocalizations.moviesLoadError),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: context.read<MainProvider>().getPopularMovies,
                  child: Text(appLocalizations.retryButtonLabel),
                ),
              ],
            ),
          );
        }

        final movies = context.select<MainProvider, List<Movie>>((value) => value.movies);
        return RefreshIndicator(
          onRefresh: context.read<MainProvider>().refresh,
          child: MovieListView(movies: movies),
        );
      }),
    );
  }
}

class MovieListView extends StatelessWidget {
  final List<Movie> movies;

  const MovieListView({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: movies.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => MovieItemView(movie: movies[index]),
      ),
    );
  }
}

class MovieItemView extends StatelessWidget {
  final Movie movie;

  const MovieItemView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: '${AppConstants.imageUrl}${movie.backdropPath}',
                height: 84,
                width: 84,
                maxWidthDiskCache: 480,
                maxHeightDiskCache: 480,
                memCacheWidth: 480,
                memCacheHeight: 480,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textTheme.titleMedium),
                  Text(movie.overview, style: textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
