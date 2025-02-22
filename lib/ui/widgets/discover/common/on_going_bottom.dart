import 'package:d_reader_flutter/core/states/pagination_state.dart';
import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class OnGoingBottomWidget extends StatelessWidget {
  final PaginationState provider;
  const OnGoingBottomWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: provider.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          onGoingLoading: (items) {
            return const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: ColorPalette.boxBackground200,
                ),
              ),
            );
          },
          onGoingError: (items, e, stk) {
            Sentry.captureException(e, stackTrace: stk);
            return const Center(
              child: Text('Something went wrong.'),
            );
          },
        ),
      ),
    );
  }
}
