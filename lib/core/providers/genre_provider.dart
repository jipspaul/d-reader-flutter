import 'package:d_reader_flutter/core/models/genre.dart';
import 'package:d_reader_flutter/core/providers/dio_provider.dart';
import 'package:d_reader_flutter/core/repositories/genre/genre_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final genreRepositoryProvider = Provider<GenreRepositoryImpl>(
  (ref) {
    return GenreRepositoryImpl(
      client: ref.watch(dioProvider),
    );
  },
);

final genreProvider = FutureProvider<List<GenreModel>>((ref) async {
  return await ref.read(genreRepositoryProvider).getGenres();
});
