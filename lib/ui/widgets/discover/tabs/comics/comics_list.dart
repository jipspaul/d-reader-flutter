import 'package:d_reader_flutter/core/models/comic.dart';
import 'package:d_reader_flutter/core/states/pagination_state.dart';
import 'package:d_reader_flutter/ui/widgets/common/cards/skeleton_card.dart';
import 'package:d_reader_flutter/ui/widgets/discover/tabs/comics/comics_results_builder.dart';
import 'package:flutter/material.dart';

class ComicList extends StatelessWidget {
  final PaginationState<ComicModel> provider;
  const ComicList({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return provider.when(
      data: (comics) {
        return ComicsResultsBuilder(comics: comics);
      },
      error: (err, stack) => Text(
        'Error: $err',
        style: const TextStyle(color: Colors.red),
      ),
      loading: () => ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) => const ComicListItemSkeleton(),
      ),
      onGoingError: (List<ComicModel> items, Object? e, StackTrace? stk) {
        return ComicsResultsBuilder(
          comics: items,
        );
      },
      onGoingLoading: (List<ComicModel> items) {
        return ComicsResultsBuilder(
          comics: items,
        );
      },
    );
  }
}

class ComicListItemSkeleton extends StatelessWidget {
  const ComicListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const SkeletonCard(
                    height: 150,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Expanded(
            flex: 7,
            child: SkeletonCard(
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
