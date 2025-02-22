import 'package:d_reader_flutter/core/models/comic_issue.dart';
import 'package:d_reader_flutter/core/states/pagination_state.dart';
import 'package:d_reader_flutter/ui/widgets/common/cards/skeleton_card.dart';
import 'package:d_reader_flutter/ui/widgets/discover/tabs/issues/issues_results_builder.dart';
import 'package:flutter/material.dart';

class IssuesList extends StatelessWidget {
  final PaginationState<ComicIssueModel> provider;
  const IssuesList({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return provider.when(
      data: (issues) {
        return IssuesResultsBuilder(issues: issues);
      },
      error: (err, stack) => Text(
        'Error: $err',
        style: const TextStyle(color: Colors.red),
      ),
      loading: () => ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) => const IssueListItemSkeleton(),
      ),
      onGoingError: (List<ComicIssueModel> items, Object? e, StackTrace? stk) {
        return IssuesResultsBuilder(
          issues: items,
        );
      },
      onGoingLoading: (List<ComicIssueModel> items) {
        return IssuesResultsBuilder(
          issues: items,
        );
      },
    );
  }
}

class IssueListItemSkeleton extends StatelessWidget {
  const IssueListItemSkeleton({super.key});

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
                    height: 145,
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
              height: 145,
            ),
          ),
        ],
      ),
    );
  }
}
