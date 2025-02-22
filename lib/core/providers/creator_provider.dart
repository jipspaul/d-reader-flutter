import 'package:d_reader_flutter/core/models/creator.dart';
import 'package:d_reader_flutter/core/notifiers/pagination_notifier.dart';
import 'package:d_reader_flutter/core/providers/dio_provider.dart';
import 'package:d_reader_flutter/core/repositories/creator/creator_repository_impl.dart';
import 'package:d_reader_flutter/core/states/pagination_state.dart';
import 'package:d_reader_flutter/ui/utils/append_default_query_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final creatorRepositoryProvider = Provider<CreatorRepositoryImpl>((ref) {
  return CreatorRepositoryImpl(
    client: ref.watch(dioProvider),
  );
});

final creatorsProvider = FutureProvider.autoDispose
    .family<List<CreatorModel>, String?>((ref, queryString) async {
  return await ref
      .read(creatorRepositoryProvider)
      .getCreators(queryString: queryString ?? appendDefaultQuery(queryString));
});

final creatorProvider =
    FutureProvider.autoDispose.family<CreatorModel?, String>((ref, slug) async {
  return await ref.read(creatorRepositoryProvider).getCreator(slug);
});

final paginatedCreatorsProvider = StateNotifierProvider.autoDispose.family<
    PaginationNotifier<CreatorModel>,
    PaginationState<CreatorModel>,
    String?>((ref, query) {
  final fetch = ref.read(creatorRepositoryProvider).getCreators;
  return PaginationNotifier<CreatorModel>(
    fetch: fetch,
    query: query,
  )..init();
});
